import 'package:flutter/gestures.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.signIn,
  });
  final VoidCallback signIn;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      backgroundColor: AppColors.primaryColorLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              largeVerticalSizedBox,
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        userSvg,
                        fit: BoxFit.cover,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              mediumVerticalSizedBox,
              Text(
                registerString,
                style: boldSize25Title(
                  AppColors.primaryColor,
                ),
              ),
              mediumVerticalSizedBox,
              Form(
                child: Column(
                  children: [
                    // full name
                    const ICareTextFormField(
                      label: fullNameString,
                      prefixIcon: Icons.person,
                      hintText: fullNameHintString,
                      fillColor: AppColors.whiteColor,
                    ),
                    mediumVerticalSizedBox,
                    // email
                    const ICareTextFormField(
                      label: emailString,
                      prefixIcon: Icons.email,
                      hintText: emailHintString,
                      fillColor: AppColors.whiteColor,
                    ),
                    mediumVerticalSizedBox,
                    // phone number
                    const ICareTextFormField(
                      label: phoneNumberString,
                      prefixIcon: Icons.phone,
                      hintText: phoneNumberHintString,
                      fillColor: AppColors.whiteColor,
                    ),
                    mediumVerticalSizedBox,
                    // password
                    ICareTextFormField(
                      label: passwordString,
                      prefixIcon: Icons.lock,
                      hintText: passwordHintString,
                      fillColor: AppColors.whiteColor,
                      obscureText: !_showPassword,
                      suffixIcon: _showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                      fillColor: AppColors.whiteColor,
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
                      fillColor: AppColors.whiteColor,
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
                    mediumVerticalSizedBox,
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ICareElevatedButton(
                        onPressed: () {},
                        text: signUpString,
                      ),
                    ),
                    smallVerticalSizedBox,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyHaveAccountString,
                            style: normalSize12Text(
                              AppColors.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: signInString,
                            style: normalSize12Text(
                              AppColors.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.signIn,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
