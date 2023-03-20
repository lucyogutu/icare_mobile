import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/user.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/enums.dart';
import 'package:icare_mobile/domain/value_objects/regex.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

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
  // Gender gender = Gender.male;
  Gender? gender;
  TextEditingController dateinput = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  DateTime? selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Future<User>? _registerUser;

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
    _showConfirmPassword = false;
  }

  User _displayGender(Gender gender) {
    if (gender == Gender.male) {
      _user = User(
        firstName: _user.firstName,
        lastName: _user.lastName,
        email: _user.email,
        phoneNumber: _user.phoneNumber,
        gender: male,
        password1: _user.password1,
        password2: _user.password2,
        dateOfBirth: _user.dateOfBirth,
      );
      return _user;
    } else if (gender == Gender.female) {
      _user = User(
        firstName: _user.firstName,
        lastName: _user.lastName,
        email: _user.email,
        phoneNumber: _user.phoneNumber,
        gender: female,
        password1: _user.password1,
        password2: _user.password2,
        dateOfBirth: _user.dateOfBirth,
      );
      return _user;
    } else {
      _user = User(
        firstName: _user.firstName,
        lastName: _user.lastName,
        email: _user.email,
        phoneNumber: _user.phoneNumber,
        gender: other,
        password1: _user.password1,
        password2: _user.password2,
        dateOfBirth: _user.dateOfBirth,
      );
      return _user;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final user = await registerUser(_user);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Registered Successfully'),
                actions: [
                  ICareTextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'OK',
                    style: boldSize14Text(AppColors.primaryColor),
                  ),
                ],
              );
            });
        _formKey.currentState!.reset();
        setState(() {
          _registerUser = Future.value(user);
        });
      } catch (error) {
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
                  style: boldSize14Text(AppColors.primaryColor),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildColumn(),
        ),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      children: [
        smallVerticalSizedBox,
        Text(
          registerString,
          style: boldSize25Title(
            AppColors.primaryColor,
          ),
        ),
        mediumVerticalSizedBox,
        Form(
          key: _formKey,
          child: Column(
            children: [
              // first name
              _buildFirstName(),
              mediumVerticalSizedBox,
              // last name
              _buildLastName(),
              mediumVerticalSizedBox,
              // email
              _buildEmail(),
              mediumVerticalSizedBox,
              // phone number
              _buildPhonenumber(),
              mediumVerticalSizedBox,
              // password
              _buildPassword(),
              mediumVerticalSizedBox,
              // confirm password
              _buildConfirmpassword(),
              mediumVerticalSizedBox,
              // gender
              _buildGender(),
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
                  // FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          1950), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    const Text(dateOfBirthHintString);
                  }
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return fieldCannotBeEmptyString;
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
                      password1: _user.password1,
                      password2: _user.password2,
                      dateOfBirth: value!,
                    );
                  });
                },
              ),
              mediumVerticalSizedBox,
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ICareElevatedButton(
                  onPressed: () {
                    _submitForm();
                    widget.signIn;
                  },
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
                      recognizer: TapGestureRecognizer()..onTap = widget.signIn,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildGender() {
    return Column(
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
                    _user = _displayGender(gender!);
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
                    _user = _user = _displayGender(gender!);
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
                    _user = _user = _displayGender(gender!);
                  });
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  ICareTextFormField _buildConfirmpassword() {
    return ICareTextFormField(
      controller: _confirmPassword,
      label: confirmPasswordString,
      prefixIcon: Icons.lock,
      hintText: confirmPasswordHintString,
      fillColor: AppColors.whiteColor,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_showConfirmPassword,
      suffixIcon:
          _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
      suffixOnPressed: () {
        setState(() {
          _showConfirmPassword = !_showConfirmPassword;
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return fieldCannotBeEmptyString;
        } else if (value != _password.text) {
          return passwordsMustMatch;
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
            password1: _user.password1,
            password2: value!,
            dateOfBirth: _user.dateOfBirth,
          );
        });
      },
    );
  }

  ICareTextFormField _buildPassword() {
    return ICareTextFormField(
      controller: _password,
      label: passwordString,
      prefixIcon: Icons.lock,
      hintText: passwordHintString,
      fillColor: AppColors.whiteColor,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_showPassword,
      suffixIcon: _showPassword ? Icons.visibility : Icons.visibility_off,
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
    );
  }

  ICareTextFormField _buildPhonenumber() {
    return ICareTextFormField(
      label: phoneNumberString,
      prefixIcon: Icons.phone,
      hintText: phoneNumberHintString,
      fillColor: AppColors.whiteColor,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return fieldCannotBeEmptyString;
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user = User(
            firstName: _user.firstName,
            lastName: _user.lastName,
            email: _user.email,
            phoneNumber: int.parse(value!),
            gender: _user.gender,
            password1: _user.password1,
            password2: _user.password2,
            dateOfBirth: _user.dateOfBirth,
          );
        });
      },
    );
  }

  ICareTextFormField _buildEmail() {
    return ICareTextFormField(
      label: emailString,
      prefixIcon: Icons.email,
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
    );
  }

  ICareTextFormField _buildLastName() {
    return ICareTextFormField(
      label: lastNameString,
      prefixIcon: Icons.person,
      hintText: lastNameHintString,
      fillColor: AppColors.whiteColor,
      validator: (String? value) {
        if (value!.isEmpty) {
          return fieldCannotBeEmptyString;
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user = User(
            firstName: _user.firstName,
            lastName: value,
            email: _user.email,
            phoneNumber: _user.phoneNumber,
            gender: _user.gender,
            password1: _user.password1,
            password2: _user.password2,
            dateOfBirth: _user.dateOfBirth,
          );
        });
      },
    );
  }

  ICareTextFormField _buildFirstName() {
    return ICareTextFormField(
      label: firstNameString,
      prefixIcon: Icons.person,
      hintText: firstNameHintString,
      fillColor: AppColors.whiteColor,
      validator: (String? value) {
        if (value!.isEmpty) {
          return fieldCannotBeEmptyString;
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user = User(
            firstName: value,
            lastName: _user.lastName,
            email: _user.email,
            phoneNumber: _user.phoneNumber,
            gender: _user.gender,
            password1: _user.password1,
            password2: _user.password2,
            dateOfBirth: _user.dateOfBirth,
          );
        });
      },
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.image,
  }) : super(key: key);

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: (image != null)
              ? ClipOval(
                  child: Image.file(image!),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                    userSvg,
                    fit: BoxFit.cover,
                    color: AppColors.primaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}
