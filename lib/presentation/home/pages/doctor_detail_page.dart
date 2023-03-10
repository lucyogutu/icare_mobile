import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/application/core/routes.dart';

class DoctorDetailPage extends StatelessWidget {
  const DoctorDetailPage({
    super.key,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.doctorProfession,
    required this.doctorClinic,
  });

  final String doctorFirstName;
  final String doctorLastName;
  final String doctorProfession;
  final String doctorClinic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$doctorFirstName +' '+$doctorLastName',
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(
                        color: AppColors.primaryColorLight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FittedBox(
                        child: SvgPicture.asset(
                          userSvg,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  mediumVerticalSizedBox,
                  Text(
                    '$doctorFirstName +' '+$doctorLastName',
                    style: boldSize25Title(AppColors.blackColor),
                  ),
                  smallVerticalSizedBox,
                  Text(
                    doctorProfession,
                    style: boldSize16Text(AppColors.blackColor),
                  ),
                  smallVerticalSizedBox,
                  Text(
                    doctorClinic,
                    style: normalSize14Text(AppColors.blackColor),
                  ),
                ],
              ),
              smallVerticalSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aboutString,
                    style: heavySize18Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  Text(
                    'Aga Khan University hospital, Kiambu . Aga Khan University hospital, Kiambu  Aga Khan University hospital, Kiambu Aga Khan University hospital, Kiambu Aga Khan University hospital, Kiambu Aga Khan University hospital, Kiambu Aga Khan University hospital, Kiambu ',
                    style: normalSize14Text(AppColors.blackColor),
                  ),
                  mediumVerticalSizedBox,
                  Text(
                    workingHoursString,
                    style: heavySize18Text(AppColors.blackColor),
                  ),
                  smallVerticalSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0800 Hrs',
                        style: normalSize16Text(
                          AppColors.blackColor,
                        ),
                      ),
                      Text(
                        '1700 Hrs',
                        style: normalSize16Text(
                          AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              mediumVerticalSizedBox,
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ICareElevatedButton(
                  text: bookAppointmentString,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.bookAppointment, arguments: {
                    'doctorFirstName': doctorFirstName,
                    'doctorLastName': doctorLastName,
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
