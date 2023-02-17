import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _showPassword;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
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
              size70VerticalSizedBox,
              Center(
                child: SvgPicture.asset(accessAccountSvg),
              ),
              largeVerticalSizedBox,
              Text(
                welcomeString,
                style: boldSize30Text(
                  AppColors.primaryColor,
                ),
              ),
              largeVerticalSizedBox,
              Form(
                child: Column(
                  children: [
                    const ICareTextFormField(
                      label: phoneNumberString,
                      prefixIcon: Icons.phone,
                      hintText: phoneNumberHintString,
                      fillColor: AppColors.whiteColor,
                    ),
                    mediumVerticalSizedBox,
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
                    smallVerticalSizedBox,
                    ICareTextButton(
                      onPressed: () {},
                      text: forgotPasswordString,
                    ),
                    smallVerticalSizedBox,
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ICareElevatedButton(
                        onPressed: () {},
                        text: signInString,
                      ),
                    ),
                    smallVerticalSizedBox,
                    Text(
                      orString,
                      textAlign: TextAlign.center,
                      style: normalSize14Text(AppColors.greyTextColor),
                    ),
                    smallVerticalSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(googleIconSvg),
                          onPressed: () {},
                        ),
                        largeHorizontalSizedBox,
                        IconButton(
                          icon: SvgPicture.asset(facebookIconSvg),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    smallVerticalSizedBox,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: dontHaveAccountString,
                            style: normalSize12Text(
                              AppColors.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: signUpString,
                            style: normalSize12Text(
                              AppColors.primaryColor,
                            ),
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
