

import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

// utils.dart, a class holding common methods

// alert dialog for logout and optout options
Future<dynamic> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback yesButton,
  required String buttonText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ICareTextButton(
            onPressed: () => Navigator.of(context).pop(),
            text: noCancel,
            style: boldSize14Text(AppColors.primaryColor),
          ),
          ICareTextButton(
            onPressed: yesButton,
            text: buttonText,
            style: boldSize14Text(AppColors.redColor),
          ),
        ],
      );
    },
  );
}

// error alert for handling futures
void errorAlert(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(errorString),
            content: const Text(' Error Occurred'),
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
  });
}

// review bottom sheet
PersistentBottomSheetController showReviewBottomSheet({
  required BuildContext context,
  required String name,
  required Widget? reviewWidget,
  required VoidCallback onPressed,
  required TextEditingController reviewController,
}) {
  return showBottomSheet(
    context: context,
    elevation: 10,
    backgroundColor: AppColors.primaryColorLight,
    builder: (_) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reviewString,
                style: boldSize18Text(AppColors.blackColor),
              ),
              smallVerticalSizedBox,
              Text(
                name,
                style: boldSize16Text(
                  AppColors.blackColor,
                ),
              ),
              smallVerticalSizedBox,
              Row(
                children: [
                  Text(
                    ratingString,
                    style: boldSize14Text(
                      AppColors.blackColor,
                    ),
                  ),
                  mediumHorizontalSizedBox,
                  reviewWidget!,
                ],
              ),
              smallVerticalSizedBox,
              TextField(
                controller: reviewController,
                maxLines: 4,
                minLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  hintText: 'Leave a review',
                  hintStyle: const TextStyle(
                    color: AppColors.greyTextColor,
                  ),
                ),
              ),
              mediumVerticalSizedBox,
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ICareElevatedButton(
                  text: reviewString,
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class DoctorSearchDelegate extends SearchDelegate {
  final Future<List<Doctor>> _doctors;

  DoctorSearchDelegate(this._doctors);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: AppColors.blackColor,
        ),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.blackColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _doctors,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final List<Doctor> doctors = snapshot.data!;
          final filteredDoctors = doctors
              .where((doctor) =>
                  doctor.firstName!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  doctor.lastName!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  doctor.specialization!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return DoctorListItemWidget(
                  id: doctor.id!,
                  doctorFirstName: doctor.firstName!,
                  doctorLastName: doctor.lastName!,
                  doctorProfession: doctor.specialization!,
                  doctorClinic: doctor.clinic!,
                  // remove hard coding
                  rating: 5,
                  reviews: 500,
                );
              },
            ),
          );
        }
        return const Center(
          child: Text('No results found.'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _doctors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final List<Doctor> doctors = snapshot.data!;
          final filteredDoctors = doctors
              .where((doctor) =>
                  doctor.firstName!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  doctor.lastName!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  doctor.specialization!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return DoctorListItemWidget(
                  id: doctor.id!,
                  doctorFirstName: doctor.firstName!,
                  doctorLastName: doctor.lastName!,
                  doctorProfession: doctor.specialization!,
                  doctorClinic: doctor.clinic!,
                  // remove hard coding
                  rating: 5,
                  reviews: 500,
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No results found.'));
        }
      },
    );
  }
}

// Future pickImage(
  //   ImageSource source,
  // ) async {
  //   Map<Permission, PermissionStatus> statuses =
  //       await [Permission.storage, Permission.camera].request();

  //   if (statuses[Permission.storage]!.isGranted &&
  //       statuses[Permission.camera]!.isGranted) {
  //     final imagePicked =
  //         await ImagePicker().pickImage(source: source).then((image) {
  //       if (image != null) {
  //         _cropImage(File(image.path));
  //       }
  //     });
  //     if (imagePicked == null) return;
  //     final imageTemporary = File(imagePicked.path);
  //     // setState(() => image = imageTemporary);
  //     setState(() {
  //       _user = User(
  //         firstName: _user.firstName,
  //         lastName: _user.lastName,
  //         email: _user.email,
  //         phoneNumber: _user.phoneNumber,
  //         gender: _user.gender,
  //         password1: _user.password1,
  //         password2: _user.password2,
  //         dateOfBirth: _user.dateOfBirth,
  //       );
  //     });
  //   } else {
  //     return 'Something Went Wrong, Failed to pick image';
  //   }

  //   try {
  //     final imagePicked = await ImagePicker().pickImage(source: source);
  //     if (imagePicked == null) return;
  //     final imageTemporary = File(imagePicked.path);
  //     // setState(() => image = imageTemporary);
  //     setState(() {
  //       _user = User(
  //         profileImage: imageTemporary,
  //         firstName: _user.firstName,
  //         lastName: _user.lastName,
  //         email: _user.email,
  //         phoneNumber: _user.phoneNumber,
  //         gender: _user.gender,
  //         password1: _user.password1,
  //         password2: _user.password2,
  //         dateOfBirth: _user.dateOfBirth,
  //       );
  //     });
  //   } catch (e) {
  //     return 'Something Went Wrong, Failed to pick image';
  //   }
  // }

  // _cropImage(File imgFile) async {
  //   final croppedImg = await ImageCropper().cropImage(
  //     sourcePath: imgFile.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: AppColors.primaryColor,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //       WebUiSettings(
  //         context: context,
  //       ),
  //     ],
  //   );
  //   if (croppedImg != null) {
  //     imageCache.clear();
  //     setState(() {
  //       _user = User(
  //         firstName: _user.firstName,
  //         lastName: _user.lastName,
  //         email: _user.email,
  //         phoneNumber: _user.phoneNumber,
  //         gender: _user.gender,
  //         password1: _user.password1,
  //         password2: _user.password2,
  //         dateOfBirth: _user.dateOfBirth,
  //       );
  //     });
  //   }
  // }