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
    Key? key,
    required this.signUp,
  }) : super(key: key);
  final VoidCallback signUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _showPassword;
  Future<User>? _loginUser;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              smallVerticalSizedBox,
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
                      suffixIcon: _showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                        setState(() {
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
                        });
                      },
                    ),
                    smallVerticalSizedBox,
                    ICareTextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.forgotPassword),
                      text: forgotPasswordString,
                      style: boldSize16Text(AppColors.primaryColor),
                    ),
                    smallVerticalSizedBox,
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ICareElevatedButton(
                        onPressed: (_loginUser == null)
                            ? () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('showHome', true);
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _loginUser = loginUser(_user);
                                  Navigator.of(context).pushReplacementNamed(
                                      AppRoutes.bottomNav);
                                }
                              }
                            : buildFutureBuilder,
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
      ),
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _loginUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const SnackBar(
            content: Text('Login successfull'),
          );
        } else if (snapshot.hasError) {
          return const Text('Error Occurred');
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
