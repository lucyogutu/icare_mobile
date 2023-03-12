import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:intl/intl.dart';

class AppointmentListItemWidget extends StatefulWidget {
  const AppointmentListItemWidget({
    super.key,
    required this.id,
    required this.doctorId,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.doctorProfession,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final int id;
  final int doctorId;
  final String doctorFirstName;
  final String doctorLastName;
  final String doctorProfession;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

  @override
  State<AppointmentListItemWidget> createState() =>
      _AppointmentListItemWidgetState();
}

class _AppointmentListItemWidgetState extends State<AppointmentListItemWidget> {
  Future<Appointment>? _cancelAppointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: AppColors.primaryColorLight,
            ),
            color: AppColors.primaryColorLight,
          ),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          // month
                          DateFormat.MMM().format(widget.date),
                          style: boldSize18Text(AppColors.blackColor),
                        ),
                        // day
                        Text(
                          DateFormat.d().format(widget.date),
                          style: boldSize25Title(AppColors.blackColor),
                        ),
                        // weekday
                        Text(
                          DateFormat.E().format(widget.date),
                          style: boldSize18Text(AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.doctorFirstName,
                              style: boldSize18Text(AppColors.blackColor),
                            ),
                            Text(
                              //start time
                              DateFormat.Hm().format(widget.startTime),
                              style: boldSize16Text(AppColors.blackColor),
                            ),
                          ],
                        ),
                        Text(
                          widget.doctorProfession,
                          style: normalSize14Text(AppColors.blackColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: ICareElevatedButton(
                                text: cancelString,
                                buttonColor: AppColors.errorColor,
                                borderColor: Colors.transparent,
                                onPressed: () {
                                  if (_cancelAppointment == null) {
                                    _cancelAppointment =
                                        cancelAppointment(widget.id);
                                  } else {
                                    FutureBuilder(
                                      future: _cancelAppointment,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return SnackBar(
                                            content: Text(
                                                'Appointment with Dr. ${widget.doctorLastName} canceled'),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Text(
                                              'Error Occurred while canceling appointment');
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              child: ICareElevatedButton(
                                text: rescheduleString,
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(AppRoutes.bookAppointment,
                                        arguments: {
                                      'doctorId': widget.doctorId,
                                      'doctorFirstName': widget.doctorFirstName,
                                      'doctorLastName': widget.doctorLastName,
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        smallVerticalSizedBox,
      ],
    );
  }
}
