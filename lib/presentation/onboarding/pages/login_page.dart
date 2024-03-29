import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/user.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/regex.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.signUp,
  });
  final VoidCallback signUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _showPassword;
  Future<User>? loginuser;
  final _formKey = GlobalKey<FormState>();

  User _user = User(
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: 0,
    gender: '',
    password1: '',
    password2: '',
    dateOfBirth: '',
  );

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            largeVerticalSizedBox,
            veryLargeVerticalSizedBox,
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
              key: _formKey,
              child: Column(
                children: [
                  ICareTextFormField(
                    label: emailString,
                    prefixIcon: Icons.mail,
                    hintText: emailHintString,
                    fillColor: AppColors.whiteColor,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (!emailRegex.hasMatch(value!) || value.isEmpty) {
                        return inputValidEmailString;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _user = User(
                        firstName: _user.firstName,
                        lastName: _user.lastName,
                        email: value!,
                        phoneNumber: _user.phoneNumber,
                        gender: _user.gender,
                        password1: _user.password1,
                        password2: _user.password2,
                        dateOfBirth: _user.dateOfBirth,
                      );
                    },
                  ),
                  mediumVerticalSizedBox,
                  ICareTextFormField(
                    label: passwordString,
                    prefixIcon: Icons.lock,
                    hintText: passwordHintString,
                    fillColor: AppColors.whiteColor,
                    obscureText: !_showPassword,
                    suffixIcon:
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                    suffixOnPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return fieldCannotBeEmptyString;
                      } else if (value.length < 8) {
                        return passwordHave8Characters;
                      } else if (isNumeric(value)) {
                        return passwordCannotContainNumbersOnly;
                      } else if (!value.contains(passwordRegex) ||
                          !value.contains(numericRegex)) {
                        return passwordTooCommonString;
                      }
                  
                      return null;
                    },
                    onSaved: (value) {
                      setState(
                        () {
                          _user = User(
                            firstName: _user.firstName,
                            lastName: _user.lastName,
                            email: _user.email,
                            phoneNumber: _user.phoneNumber,
                            gender: _user.gender,
                            password1: value!,
                            password2: _user.password2,
                            dateOfBirth: _user.dateOfBirth,
                          );
                        },
                      );
                    },
                  ),
                  smallVerticalSizedBox,
                  // ICareTextButton(
                  //   onPressed: () =>
                  //       Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
                  //   text: forgotPasswordString,
                  //   style: boldSize16Text(AppColors.primaryColor),
                  // ),
                  largeVerticalSizedBox,
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ICareElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', true);
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          try {
                            final user = await loginUser(_user);
                            if (!context.mounted) return;
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.bottomNav);

                            // firebase analytics event logging
                            await FirebaseAnalytics.instance.logEvent(
                              name: 'User log-in',
                              parameters: {
                                "user": "${_user.firstName} ${_user.lastName}",
                                "email": _user.email,
                              },
                            );
                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Login Successful'),
                              backgroundColor: (Colors.black87),
                              duration: const Duration(seconds: 5),
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ));
                            setState(() {
                              loginuser = Future.value(user);
                            });
                          } catch (error) {
                            if (!context.mounted) return;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Something went wrong'),
                                    content: Text(error.toString()),
                                    actions: [
                                      ICareTextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: 'OK',
                                        style: boldSize14Text(
                                            AppColors.primaryColor),
                                      ),
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      text: signInString,
                    ),
                  ),
                  smallVerticalSizedBox,
                  // Text(
                  //   orString,
                  //   textAlign: TextAlign.center,
                  //   style: normalSize14Text(AppColors.greyTextColor),
                  // ),
                  // smallVerticalSizedBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       icon: SvgPicture.asset(googleIconSvg),
                  //       onPressed: () => AuthService().signInWithgoogle(),
                  //     ),
                  //     largeHorizontalSizedBox,
                  //     IconButton(
                  //       icon: SvgPicture.asset(facebookIconSvg),
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.signUp,
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
    );
  }
}
