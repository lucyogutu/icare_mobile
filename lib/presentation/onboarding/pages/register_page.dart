import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/user.dart';
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
  // Gender gender = Gender.male;
  Gender? gender;
  TextEditingController dateinput = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  DateTime? selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final User _user = User();

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _showConfirmPassword = false;
  }

  Widget _displayGender() {
    if (_user.gender == Gender.male.toString()) {
      return const Text('Gender: Male');
    } else if (_user.gender == Gender.female.toString()) {
      return const Text('Gender: Female');
    } else {
      return const Text('Gender: Other');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Show alert dialog with user details
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Name: ${_user.firstName} ${_user.lastName}'),
                Text('Email: ${_user.email}'),
                // Text('Gender: ${_user.gender}'),
                _displayGender(),
                Text(
                    'Date of Birth: ${DateFormat('yyyy-MM-dd').format(_user.dateOfBirth!)}'),
                Text('Password: ${_user.password1}'),
                Text('Phone Number: ${_user.phoneNumber}'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _user.dateOfBirth = DateTime.tryParse(value!);
                        });
                      },
                    ),
                    mediumVerticalSizedBox,
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ICareElevatedButton(
                        onPressed: _submitForm,
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
                    _user.gender = gender.toString();
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
                    _user.gender = gender.toString();
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
                    _user.gender = gender.toString();
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
          return 'Field cannot be empty';
        } else if (value != _password.text) {
          return 'Passwords must match';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user.password2 = value;
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
          return 'Field cannot be empty';
        } else if (value.length < 8) {
          return 'Passwords must atleast be of 8 characters';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user.password1 = value;
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
          return 'Field cannot be empty';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user.phoneNumber = value;
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
        if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value!) ||
            value.isEmpty) {
          return 'Please input a valid email';
        }
        return null;
      },
      onSaved: (value) {
        _user.email = value;
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
          return 'Field cannot be empty';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user.lastName = value;
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
          return 'Field cannot be empty';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user.firstName = value;
        });
      },
    );
  }
}
