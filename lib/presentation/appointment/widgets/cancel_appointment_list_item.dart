import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:intl/intl.dart';

class CancelAppointmentListItemWidget extends StatelessWidget {
  const CancelAppointmentListItemWidget({
    super.key,
    required this.doctorId,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.doctorProfession,
    required this.doctorClinic,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final int doctorId;
  final String doctorFirstName;
  final String doctorLastName;
  final String doctorProfession;
  final String doctorClinic;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

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
                          DateFormat.MMM().format(date),
                          style: boldSize16Text(AppColors.blackColor),
                        ),
                        Text(
                          DateFormat.d().format(date),
                          style: boldSize25Title(AppColors.blackColor),
                        ),
                        Text(
                          DateFormat.E().format(date),
                          style: boldSize16Text(AppColors.blackColor),
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
                              'Dr. $doctorFirstName $doctorLastName',
                              style: boldSize16Text(AppColors.blackColor),
                            ),
                            Text(
                              DateFormat.jm().format(startTime),
                              style: boldSize16Text(AppColors.blackColor),
                            ),
                          ],
                        ),
                        Text(
                          doctorProfession,
                          style: boldSize14Text(AppColors.blackColor),
                        ),
                        Text(
                          doctorClinic,
                          style: normalSize14Text(AppColors.blackColor),
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ICareElevatedButton(
                        //     text: rescheduleString,
                        //     onPressed: () => Navigator.of(context).pushNamed(
                        //       AppRoutes.rescheduleAppointment,
                        //       arguments: {
                        //         'doctorId': doctorId,
                        //         'doctorFirstName': doctorFirstName,
                        //         'doctorLastName': doctorLastName,
                        //         'appointmentDate': date,
                        //         // 'appointmentId': id,
                        //       },
                        //     ),
                        //   ),
                        // ),
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
