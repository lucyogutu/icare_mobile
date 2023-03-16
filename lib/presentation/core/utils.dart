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

// review bottom sheet
PersistentBottomSheetController<dynamic> showReviewBottomSheet(
    BuildContext context, String name) {
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
                  children: const [
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                  ],
                ),
                smallVerticalSizedBox,
                TextField(
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
                const SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ICareElevatedButton(text: reviewString),
                ),
              ],
            ),
          ),
        );
      });
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
