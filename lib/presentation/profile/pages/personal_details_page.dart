import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/user.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:icare_mobile/presentation/core/utils.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  Future<User>? _getProfileDetails;

  @override
  void initState() {
    super.initState();
    _getProfileDetails = getProfile();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: _getProfileDetails,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  errorAlert(context);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // smallVerticalSizedBox,
                    // Center(
                    //   child: Container(
                    //     height: 120,
                    //     width: 120,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       color: AppColors.primaryColor.withOpacity(0.25),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: FittedBox(
                    //         child: SvgPicture.asset(userSvg),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    smallVerticalSizedBox,
                    Text(
                      '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
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
                          firstNameString,
                          style: boldSize14Text(AppColors.blackColor),
                        ),
                        verySmallVerticalSizedBox,
                        ICareTextFormField(
                          label: snapshot.data!.firstName!,
                          prefixIcon: Icons.person,
                          fillColor: AppColors.primaryColorLight,
                          readOnly: true,
                        ),
                        verySmallVerticalSizedBox,
                        Text(
                          lastNameString,
                          style: boldSize14Text(AppColors.blackColor),
                        ),
                        verySmallVerticalSizedBox,
                        ICareTextFormField(
                          label: snapshot.data!.lastName!,
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
                        ICareTextFormField(
                          label: snapshot.data!.email!,
                          prefixIcon: Icons.mail,
                          fillColor: AppColors.primaryColorLight,
                          readOnly: true,
                        ),
                        verySmallVerticalSizedBox,
                        Text(
                          phoneNumberString,
                          style: boldSize14Text(AppColors.blackColor),
                        ),
                        verySmallVerticalSizedBox,
                        ICareTextFormField(
                          label: '0${snapshot.data!.phoneNumber!}',
                          prefixIcon: Icons.phone,
                          fillColor: AppColors.primaryColorLight,
                          readOnly: true,
                        ),
                        verySmallVerticalSizedBox,
                        Text(
                          genderString,
                          style: boldSize14Text(AppColors.blackColor),
                        ),
                        verySmallVerticalSizedBox,
                        ICareTextFormField(
                          label: snapshot.data!.gender!,
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
                        ICareTextFormField(
                          label: snapshot.data!.dateOfBirth!,
                          prefixIcon: Icons.calendar_today,
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
                        onPressed: () => Navigator.of(context).pushNamed(
                          AppRoutes.editPersonalDetails,
                          arguments: _getProfileDetails,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
