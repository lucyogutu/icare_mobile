import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:intl/intl.dart';

class AppointmentListItemWidget extends StatefulWidget {
  const AppointmentListItemWidget({
    super.key,
    required this.id,
    required this.doctorId,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.doctorProfession,
    required this.doctorClinic,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final int id;
  final int doctorId;
  final String doctorFirstName;
  final String doctorLastName;
  final String doctorProfession;
  final String doctorClinic;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

  @override
  State<AppointmentListItemWidget> createState() =>
      _AppointmentListItemWidgetState();
}

class _AppointmentListItemWidgetState extends State<AppointmentListItemWidget> {
  Future<Appointment>? cancelappointment;

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
                                'Dr. ${widget.doctorFirstName} ${widget.doctorLastName}',
                                style: boldSize16Text(AppColors.blackColor),
                              ),
                              Text(
                                //start time
                                DateFormat.jm().format(widget.startTime),
                                style: boldSize16Text(AppColors.blackColor),
                              ),
                            ],
                          ),
                          smallVerticalSizedBox,
                          Text(
                            widget.doctorProfession,
                            style: boldSize14Text(AppColors.blackColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.doctorClinic,
                                style: boldSize14Text(AppColors.blackColor),
                              ),
                              SizedBox(
                                child: ICareElevatedButton(
                                  text: cancelString,
                                  buttonColor: AppColors.errorColor,
                                  borderColor: Colors.transparent,
                                  onPressed: () async {
                                    try {
                                      final appointment =
                                          await cancelAppointment(widget.id);
                                      if (!context.mounted) return;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final currentContext = context;

                                          return AlertDialog(
                                            title: const Text('Success'),
                                            content: Text(
                                                'Appointment with Dr. ${widget.doctorLastName} canceled'),
                                            actions: [
                                              ICareTextButton(
                                                onPressed: () {
                                                  Navigator.of(currentContext)
                                                      .pop();
                                                },
                                                text: 'OK',
                                                style: boldSize14Text(
                                                    AppColors.primaryColor),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      setState(() async {
                                        await getUpcomingAppointments();
                                        cancelappointment =
                                            Future.value(appointment);
                                      });
                                    } catch (error) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Something went wrong'),
                                            content: Text(error.toString()),
                                            actions: [
                                              ICareTextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                text: 'OK',
                                                style: boldSize14Text(
                                                    AppColors.primaryColor),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              // SizedBox(
                              //   child: ICareElevatedButton(
                              //     text: rescheduleString,
                              //     onPressed: () => Navigator.of(context)
                              //         .pushNamed(
                              //             AppRoutes.rescheduleAppointment,
                              //             arguments: {
                              //           'doctorId': widget.doctorId,
                              //           'doctorFirstName':
                              //               widget.doctorFirstName,
                              //           'doctorLastName': widget.doctorLastName,
                              //           'appointmentDate': widget.date,
                              //           'appointmentId': widget.id,
                              //         }),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        smallVerticalSizedBox,
      ],
    );
  }
}
