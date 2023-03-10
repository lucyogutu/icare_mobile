import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/presentation/core/icare_search_field.dart';
import 'package:icare_mobile/presentation/core/zero_state_widget.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

class CategorySpecificPage extends StatelessWidget {
  const CategorySpecificPage({
    super.key,
    required this.id,
    required this.label,
  });

  final String id;
  final String label;

  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = [
      // Doctor(
      //   name: 'Ali Yusuf',
      //   profession: 'Dentist',
      //   clinic: 'Aga Khan hospital, Kiambu',
      //   rating: 5,
      //   reviews: 500,
      // ),
      // Doctor(
      //   name: 'Rian Ramires',
      //   profession: 'Nurse',
      //   clinic: 'St. Anne\'s hospital, Kisumu',
      //   rating: 5,
      //   reviews: 500,
      // ),
      // Doctor(
      //   name: 'Bruno Rodrigues',
      //   profession: 'Physician',
      //   clinic: 'MP Shar hospital, Nairobi',
      //   rating: 5,
      //   reviews: 450,
      // ),
      // Doctor(
      //   name: 'Rian Ramires',
      //   profession: 'Nurse',
      //   clinic: 'St. Anne\'s hospital, Kisumu',
      //   rating: 5,
      //   reviews: 500,
      // ),
      // Doctor(
      //   name: 'Bruno Rodrigues',
      //   profession: 'Physician',
      //   clinic: 'MP Shar hospital, Nairobi',
      //   rating: 5,
      //   reviews: 450,
      // ),
    ];

    List<Doctor> filteredDoctors = doctors.where((doctor) {
      return doctor.specialization!.contains(label);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            smallHorizontalSizedBox,
            ICareSearchField(
              hintText: 'search',
              onSubmitted: (value) {},
            ),
            mediumVerticalSizedBox,
            Column(
              children: [
                if (filteredDoctors.isNotEmpty) ...[
                  ...filteredDoctors.map((doctor) {
                    return DoctorListItemWidget(
                    doctorFirstName: doctor.firstName!,
                    doctorLastName: doctor.lastName!,
                    doctorProfession: doctor.specialization!,
                    doctorClinic: doctor.clinic!,
                    // remove hard coding
                    rating: 5,
                    reviews: 500,
                  );
                  }).toList(),
                ] else
                  ZeroStateWidget(
                    text: 'No $label doctors',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
