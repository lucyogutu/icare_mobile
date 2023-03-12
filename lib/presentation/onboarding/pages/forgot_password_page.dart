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

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          forgotPasswordString,
          style: boldSize18Text(AppColors.whiteColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              largeVerticalSizedBox,
              const ICareTextFormField(
                label: emailString,
                prefixIcon: Icons.email,
                hintText: emailHintString,
                fillColor: AppColors.primaryColorLight,
              ),
              
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ICareElevatedButton(
                  onPressed: () {},
                  text: sendString,
                ),
              ),
              ICareTextButton(
                onPressed: () {},
                text: backToSignInString,
                style: boldSize16Text(AppColors.primaryColor),
              ),
              Text(
                orString,
                textAlign: TextAlign.center,
                style: normalSize14Text(AppColors.greyTextColor),
              ),
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
      ),
    );
  }
}
