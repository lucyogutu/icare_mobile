import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/enums.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';
import 'package:intl/intl.dart';

class EditPersonalDetailsPage extends StatefulWidget {
  const EditPersonalDetailsPage({super.key});

  @override
  State<EditPersonalDetailsPage> createState() =>
      _EditPersonalDetailsPageState();
}

class _EditPersonalDetailsPageState extends State<EditPersonalDetailsPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  Gender? gender;
  TextEditingController dateinput = TextEditingController();

  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _showConfirmPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editPersonalDetailsString,
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
                  // full name
                  const ICareTextFormField(
                    label: fullNameString,
                    prefixIcon: Icons.person,
                    hintText: fullNameHintString,
                    fillColor: AppColors.primaryColorLight,
                  ),
                  mediumVerticalSizedBox,
                  // email
                  const ICareTextFormField(
                    label: emailString,
                    prefixIcon: Icons.email,
                    hintText: emailHintString,
                    fillColor: AppColors.primaryColorLight,
                  ),
                  mediumVerticalSizedBox,
                  // phone number
                  const ICareTextFormField(
                    label: phoneNumberString,
                    prefixIcon: Icons.phone,
                    hintText: phoneNumberHintString,
                    fillColor: AppColors.primaryColorLight,
                  ),
                  mediumVerticalSizedBox,
                  // password
                  ICareTextFormField(
                    label: passwordString,
                    prefixIcon: Icons.lock,
                    hintText: passwordHintString,
                    fillColor: AppColors.primaryColorLight,
                    obscureText: !_showPassword,
                    suffixIcon:
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                    suffixOnPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  mediumVerticalSizedBox,
                  // confirm password
                  ICareTextFormField(
                    label: confirmPasswordString,
                    prefixIcon: Icons.lock,
                    hintText: confirmPasswordHintString,
                    fillColor: AppColors.primaryColorLight,
                    obscureText: !_showConfirmPassword,
                    suffixIcon: _showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    suffixOnPressed: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                  ),
                  mediumVerticalSizedBox,
                  // gender
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          genderString,
                          style: boldSize14Text(AppColors.primaryColor),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                male,
                                style: normalSize14Text(AppColors.blackColor),
                              ),
                              value: Gender.male,
                              groupValue: gender,
                              activeColor: AppColors.primaryColor,
                              onChanged: (Gender? genderValue) {
                                setState(() {
                                  gender = genderValue;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                female,
                                style: normalSize14Text(AppColors.blackColor),
                              ),
                              value: Gender.female,
                              groupValue: gender,
                              activeColor: AppColors.primaryColor,
                              onChanged: (Gender? genderValue) {
                                setState(() {
                                  gender = genderValue;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                other,
                                style: normalSize14Text(AppColors.blackColor),
                              ),
                              value: Gender.other,
                              groupValue: gender,
                              activeColor: AppColors.primaryColor,
                              onChanged: (Gender? genderValue) {
                                setState(() {
                                  gender = genderValue;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  mediumVerticalSizedBox,
                  // date of birth
                  ICareTextFormField(
                    controller: dateinput,
                    label: dateOfBirthString,
                    readOnly: true,
                    prefixIcon: Icons.calendar_today_rounded,
                    hintText: dateOfBirthHintString,
                    fillColor: AppColors.primaryColorLight,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              1950), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        const Text(dateOfBirthHintString);
                      }
                    },
                  ),
                ],
              ),
              mediumVerticalSizedBox,
              const SizedBox(
                width: double.infinity,
                height: 40,
                child: ICareElevatedButton(
                  text: saveString,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
