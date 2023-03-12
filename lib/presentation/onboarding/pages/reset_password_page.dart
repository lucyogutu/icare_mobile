import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';

import '../../../domain/value_objects/app_widget_keys.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;

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
          newPasswordString,
          style: boldSize18Text(AppColors.whiteColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            largeVerticalSizedBox,
            // password
            ICareTextFormField(
              key: newPasswordKey,
              label: passwordString,
              prefixIcon: Icons.lock,
              hintText: passwordHintString,
              fillColor: AppColors.primaryColorLight,
              obscureText: !_showPassword,
              suffixIcon: _showPassword ? Icons.visibility : Icons.visibility_off,
              suffixOnPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            mediumVerticalSizedBox,
            // confirm password
            ICareTextFormField(
              key: confirmNewPasswordKey,
              label: confirmPasswordString,
              prefixIcon: Icons.lock,
              hintText: confirmPasswordHintString,
              fillColor: AppColors.primaryColorLight,
              obscureText: !_showConfirmPassword,
              suffixIcon:
                  _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
              suffixOnPressed: () {
                setState(() {
                  _showConfirmPassword = !_showConfirmPassword;
                });
              },
            ),
            largeVerticalSizedBox,
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ICareElevatedButton(
                onPressed: () {},
                text: submitString,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
