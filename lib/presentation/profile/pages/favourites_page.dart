import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = [
      Doctor(
        name: 'Ali Yusuf',
        profession: 'Dentist',
        clinic: 'Aga Khan hospital, Kiambu',
        rating: 5,
        reviews: 500,
      ),
      Doctor(
        name: 'Rian Ramires',
        profession: 'Nurse',
        clinic: 'St. Anne\'s hospital, Kisumu',
        rating: 5,
        reviews: 500,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          favouriteString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ...doctors.map((doctor) {
                return DoctorListItemWidget(
                  doctorName: doctor.name,
                  doctorProfession: doctor.profession,
                  doctorClinic: doctor.clinic,
                  rating: doctor.rating,
                  reviews: doctor.reviews,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
