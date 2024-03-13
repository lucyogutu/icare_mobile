import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/user.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/enums.dart';
import 'package:icare_mobile/domain/value_objects/regex.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_form_field.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class EditPersonalDetailsPage extends StatefulWidget {
  const EditPersonalDetailsPage({super.key, required this.getProfileDetails});

  final Future<User>? getProfileDetails;

  @override
  State<EditPersonalDetailsPage> createState() =>
      _EditPersonalDetailsPageState();
}

class _EditPersonalDetailsPageState extends State<EditPersonalDetailsPage> {
  bool _showPassword = false;
  Gender? gender;
  TextEditingController dateinput = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate = DateTime.now();

  Future<User>? editProfileDetails;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    widget.getProfileDetails;
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: widget.getProfileDetails,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  errorAlert(context);
                }
                firstName.text = snapshot.data!.firstName!;
                lastName.text = snapshot.data!.lastName!;
                email.text = snapshot.data!.email!;
                phoneNumber.text = '0${snapshot.data!.phoneNumber}';
                // gender = snapshot.data!.gender as Gender;
                dateinput.text = snapshot.data!.dateOfBirth!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // smallVerticalSizedBox,
                    // Center(
                    //   child: Container(
                    //     height: 120,
                    //     width: 120,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       color: AppColors.primaryColor.withOpacity(0.25),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: FittedBox(
                    //         child: SvgPicture.asset(userSvg),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    smallVerticalSizedBox,
                    Text(
                      '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                      style: boldSize18Text(AppColors.blackColor),
                    ),
                    verySmallVerticalSizedBox,
                    Divider(
                      color: AppColors.primaryColor.withOpacity(0.25),
                    ),
                    verySmallVerticalSizedBox,
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // first name
                          ICareTextFormField(
                            controller: firstName,
                            label: firstNameString,
                            prefixIcon: Icons.person,
                            hintText: firstNameHintString,
                            fillColor: AppColors.primaryColorLight,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return fieldCannotBeEmptyString;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user = User(
                                  firstName: value!,
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
                          ),
                          mediumVerticalSizedBox,
                          // last name
                          ICareTextFormField(
                            controller: lastName,
                            label: lastNameString,
                            prefixIcon: Icons.person,
                            hintText: lastNameHintString,
                            fillColor: AppColors.primaryColorLight,
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
                                  lastName: value!,
                                  email: _user.email,
                                  phoneNumber: _user.phoneNumber,
                                  gender: _user.gender,
                                  password1: _user.password1,
                                  password2: _user.password2,
                                  dateOfBirth: _user.dateOfBirth,
                                );
                              });
                            },
                          ),
                          mediumVerticalSizedBox,
                          // email
                          ICareTextFormField(
                            controller: email,
                            label: emailString,
                            prefixIcon: Icons.email,
                            hintText: emailHintString,
                            fillColor: AppColors.primaryColorLight,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (!emailRegex.hasMatch(value!) ||
                                  value.isEmpty) {
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
                          // phone number
                          ICareTextFormField(
                            controller: phoneNumber,
                            label: phoneNumberString,
                            prefixIcon: Icons.phone,
                            hintText: phoneNumberHintString,
                            fillColor: AppColors.primaryColorLight,
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
                          ),
                          mediumVerticalSizedBox,
                          // password
                          ICareTextFormField(
                            controller: password,
                            label: passwordString,
                            prefixIcon: Icons.lock,
                            hintText: passwordHintString,
                            fillColor: AppColors.primaryColorLight,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text(
                                        male,
                                        style: normalSize14Text(
                                            AppColors.blackColor),
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
                                        style: normalSize14Text(
                                            AppColors.blackColor),
                                      ),
                                      value: Gender.female,
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
                                        other,
                                        style: normalSize14Text(
                                            AppColors.blackColor),
                                      ),
                                      value: Gender.other,
                                      groupValue: gender,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (Gender? genderValue) {
                                        setState(() {
                                          gender = genderValue;
                                          _user = _displayGender(gender!);
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
                        ],
                      ),
                    ),
                    mediumVerticalSizedBox,
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ICareElevatedButton(
                        text: saveString,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              final user = await editUserProfile(_user);
                              if (!context.mounted) return;

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Success'),
                                      content: const Text(
                                          'User profile updated Successfully'),
                                      actions: [
                                        ICareTextButton(
                                          onPressed: () {
                                            widget.getProfileDetails;
                                            Navigator.of(context).pop();
                                          },
                                          text: 'OK',
                                          style: boldSize14Text(
                                              AppColors.primaryColor),
                                        ),
                                      ],
                                    );
                                  });
                              widget.getProfileDetails;
                              _formKey.currentState!.reset();
                              setState(() {
                                editProfileDetails = Future.value(user);
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
                                },
                              );
                            }
                          }
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
