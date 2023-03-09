import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';
import 'package:icare_mobile/application/core/routes.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          personalDetailsString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              smallVerticalSizedBox,
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.primaryColor.withOpacity(0.25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FittedBox(
                      child: SvgPicture.asset(userSvg),
                    ),
                  ),
                ),
              ),
              smallVerticalSizedBox,
              Text(
                fullNameHintString,
                style: boldSize18Text(AppColors.blackColor),
              ),
              verySmallVerticalSizedBox,
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullNameString,
                    style: boldSize14Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  const ICareTextFormField(
                    label: fullNameHintString,
                    prefixIcon: Icons.person,
                    fillColor: AppColors.primaryColorLight,
                    readOnly: true,
                  ),
                  verySmallVerticalSizedBox,
                  Text(
                    emailString,
                    style: boldSize14Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  const ICareTextFormField(
                    label: emailHintString,
                    prefixIcon: Icons.person,
                    fillColor: AppColors.primaryColorLight,
                    readOnly: true,
                  ),
                  verySmallVerticalSizedBox,
                  Text(
                    phoneNumberString,
                    style: boldSize14Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  const ICareTextFormField(
                    label: phoneNumberHintString,
                    prefixIcon: Icons.person,
                    fillColor: AppColors.primaryColorLight,
                    readOnly: true,
                  ),
                  verySmallVerticalSizedBox,
                  Text(
                    genderString,
                    style: boldSize14Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  const ICareTextFormField(
                    label: 'Male',
                    prefixIcon: Icons.person,
                    fillColor: AppColors.primaryColorLight,
                    readOnly: true,
                  ),
                  verySmallVerticalSizedBox,
                  Text(
                    dateOfBirthString,
                    style: boldSize14Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  const ICareTextFormField(
                    label: dateOfBirthHintString,
                    prefixIcon: Icons.person,
                    fillColor: AppColors.primaryColorLight,
                    readOnly: true,
                  ),
                ],
              ),
              mediumVerticalSizedBox,
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ICareElevatedButton(
                  text: editString,
                  onPressed: () => Navigator.of(context).pushNamed(AppRoutes.editPersonalDetails),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
