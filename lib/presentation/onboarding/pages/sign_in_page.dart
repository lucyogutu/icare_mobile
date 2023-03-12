import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/onboarding/widgets/sign_in_list_item.dart';

// removed this page from iCare screen layout

class SignInPage extends StatelessWidget {
  const SignInPage({
    super.key,
    required this.navigateLogin,
    required this.navigateRegister,
  });

  final VoidCallback navigateLogin;
  final VoidCallback navigateRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                largeVerticalSizedBox,
                Center(
                  child: SvgPicture.asset(mobileLoginSvg),
                ),
                largeVerticalSizedBox,
                Text(
                  letYouInString,
                  style: boldSize30Text(
                    AppColors.primaryColor,
                  ),
                ),
                largeVerticalSizedBox,
                SignInListItem(
                  svgValue: facebookIconSvg,
                  title: continueFacebookString,
                  onTap: () {},
                ),
                mediumVerticalSizedBox,
                SignInListItem(
                  svgValue: googleIconSvg,
                  title: continueGoogleString,
                  onTap: () {},
                ),
                largeVerticalSizedBox,
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ICareElevatedButton(
                    text: signInPassword,
                    onPressed: navigateLogin,
                  ),
                ),
                mediumVerticalSizedBox,
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = navigateRegister,
                      ),
                    ],
                  ),
                ),
                mediumVerticalSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
