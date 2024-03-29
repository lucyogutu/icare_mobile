import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/zero_state_widget.dart';

class RescheduleAppointmentPage extends StatefulWidget {
  const RescheduleAppointmentPage({
    super.key,
    required this.doctorId,
    required this.appointmentId,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.appointmentDate,
  });

  final int doctorId;
  final int appointmentId;
  final String doctorFirstName;
  final String doctorLastName;
  final DateTime appointmentDate;

  @override
  State<RescheduleAppointmentPage> createState() =>
      _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState extends State<RescheduleAppointmentPage> {
  CalendarFormat _format = CalendarFormat.twoWeeks;
  DateTime? _focusDay;
  DateTime currentDay = DateTime.now();

  int? _currentIndex;
  // bool _isWeekend = false;
  bool dateSelected = false;
  bool timeSelected = false;

  Future<Appointment>? _rescheduleAppointment;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusDay = widget.appointmentDate;
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    DateTime startTime;
    DateTime endTime;
    Duration step = const Duration(minutes: 60);
    List<String> timeSlots = [];

    bool isToday = _focusDay?.year == DateTime.now().year &&
        _focusDay?.month == DateTime.now().month &&
        _focusDay?.day == DateTime.now().day;

    if (isToday) {
      timeSlots.clear();
      startTime = DateTime(_focusDay!.year, _focusDay!.month, _focusDay!.day,
          DateTime.now().hour, 0, 0);
      endTime =
          DateTime(_focusDay!.year, _focusDay!.month, _focusDay!.day, 23, 0, 0);
      while (startTime.isBefore(endTime)) {
        DateTime timeIncrement = startTime.add(step);
        timeSlots.add(DateFormat.jm().format(timeIncrement));
        startTime = timeIncrement;
      }
    } else if (!isToday) {
      timeSlots.clear();
      startTime =
          DateTime(_focusDay!.year, _focusDay!.month, _focusDay!.day, 6, 0, 0);
      endTime =
          DateTime(_focusDay!.year, _focusDay!.month, _focusDay!.day, 23, 0, 0);
      while (startTime.isBefore(endTime)) {
        DateTime timeIncrement = startTime.add(step);
        timeSlots.add(DateFormat.jm().format(timeIncrement));
        startTime = timeIncrement;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.doctorFirstName} ${widget.doctorLastName}',
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColorLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: tableCalender(),
                      ),
                    ),
                    mediumVerticalSizedBox,
                    Text(
                      'Choose a time slot below',
                      style: boldSize16Text(AppColors.blackColor),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: size15VerticalSizedBox,
              ),
              if (timeSlots.isEmpty)
                SliverToBoxAdapter(
                  child: ZeroStateWidget(
                    text: 'Time slots done for the day',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return InkWell(
                      splashColor: AppColors.primaryColor,
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          timeSelected = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: _currentIndex == index
                          //       ? Colors.white
                          //       : AppColors.primaryColor,
                          // ),
                          borderRadius: BorderRadius.circular(10),
                          color: _currentIndex == index
                              ? AppColors.primaryColor
                              : AppColors.primaryColorLight,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          timeSlots[index].toString(),
                          // '${index + 7}:00 ${index + 7 > 11 ? "PM" : "AM"}',
                          style: boldSize14Text(
                            _currentIndex == index
                                ? AppColors.whiteColor
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: timeSlots.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: largeVerticalSizedBox,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: FloatingActionButton.extended(
          onPressed: () {
            // showAlertDialog(
            //   context: context,
            //   title: 'Book',
            //   content:
            //       '${DateFormat.yMd().format(_focusDay!)} ${timeSlots[_currentIndex!].toString()}',
            //   yesButton: () {},
            //   buttonText: "Back",
            // );

            DateTime startTimeJm =
                DateFormat.jm().parse(timeSlots[_currentIndex!]);

            String startTime = DateFormat.Hms().format(startTimeJm);

            DateTime endTimeDate = DateTime.parse(
                    '${DateFormat('yyyy-MM-dd').format(_focusDay!)} $startTime')
                .add(
              const Duration(
                minutes: 60,
              ),
            );
            String endTime = DateFormat.Hms().format(endTimeDate);

            Appointment appointment = Appointment(
              doctor: widget.doctorId,
              date: DateFormat('yyyy-MM-dd').format(_focusDay!),
              startTime: startTime,
              endTime: endTime,
            );
            if (_rescheduleAppointment == null) {
              _rescheduleAppointment =
                  rescheduleAppointment(appointment, widget.appointmentId);
            } else {
              FutureBuilder(
                future: _rescheduleAppointment,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const SnackBar(
                      content: Text('Appointment rescheduled'),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error Occurred');
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
          },
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          label: Text(
            rescheduleAppointmentString,
            style: boldSize16Text(AppColors.whiteColor),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  TableCalendar<dynamic> tableCalender() {
    return TableCalendar(
      focusedDay: _focusDay!,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _focusDay!,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
            color: AppColors.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.twoWeeks: 'Weeks',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          currentDay = selectedDay;
          _focusDay = focusedDay;
          dateSelected = true;
        });
      }),
    );
  }
}
