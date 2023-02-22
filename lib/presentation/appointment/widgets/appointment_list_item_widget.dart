import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/routes.dart';
import 'package:intl/intl.dart';

class AppointmentListItemWidget extends StatelessWidget {
  const AppointmentListItemWidget({
    super.key,
    required this.doctorName,
    required this.doctorProfession,
    required this.date,
  });

  final String doctorName;
  final String doctorProfession;
  final DateTime date;

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
                              doctorName,
                              style: boldSize18Text(AppColors.blackColor),
                            ),
                            Text(
                              DateFormat.Hm().format(date),
                              style: boldSize16Text(AppColors.blackColor),
                            ),
                          ],
                        ),
                        Text(
                          doctorProfession,
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
                                onPressed: (){},
                              ),
                            ),
                            SizedBox(
                              child: ICareElevatedButton(
                                text: rescheduleString,
                                onPressed: () => Navigator.of(context).pushNamed(
                                AppRoutes.bookAppointment,
                                arguments: doctorName),
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
