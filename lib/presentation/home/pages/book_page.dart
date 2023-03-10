import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.doctorFirstName,
    required this.doctorLastName,
  });

  final String doctorFirstName;
  final String doctorLastName;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  CalendarFormat _format = CalendarFormat.twoWeeks;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();

  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    DateTime startTime =
        DateTime(_focusDay.year, _focusDay.month, _focusDay.day, 6, 0, 0);
    DateTime endTime =
        DateTime(_focusDay.year, _focusDay.month, _focusDay.day, 22, 0, 0);
    Duration step = const Duration(minutes: 60);

    List<String> timeSlots = [];

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(step);
      timeSlots.add(DateFormat.jm().format(timeIncrement));
      startTime = timeIncrement;
      // DateFormat.jm().format(timeIncrement)
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.doctorFirstName} + '' + ${widget.doctorLastName}',
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
      ),
      body: Padding(
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
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    splashColor: AppColors.primaryColor,
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                        _timeSelected = true;
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
                          _currentIndex == index ? AppColors.whiteColor : null,
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
              child: mediumVerticalSizedBox,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: FloatingActionButton.extended(
          onPressed: () {
            showAlertDialog(
              context: context,
              title: 'Book',
              content:
                  '${DateFormat.yMd().format(_focusDay)} ${timeSlots[_currentIndex!].toString()}',
              yesButton: () {},
              buttonText: "Back",
            );
          },
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          label: Text(
            bookAppointmentString,
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
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
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
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          // if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
          //   _isWeekend = true;
          //   _timeSelected = false;
          //   _currentIndex = null;
          // } else {
          //   _isWeekend = false;
          // }
        });
      }),
    );
  }
}
