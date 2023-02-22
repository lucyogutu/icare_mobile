import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/category.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_search_field.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/routes.dart';
import 'package:icare_mobile/presentation/home/widgets/carousel.dart';
import 'package:icare_mobile/presentation/home/widgets/category_widget.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Category> categories = [
      Category(
        id: physicianString,
        name: physicianString,
        svgPicture: handCareSvg,
      ),
      Category(
        id: dentistString,
        name: dentistString,
        svgPicture: toothSvg,
      ),
      Category(
        id: psychologistString,
        name: psychologistString,
        svgPicture: brainSvg,
      ),
      Category(
        id: pharmacistString,
        name: pharmacistString,
        svgPicture: firstAidKitSvg,
      ),
      Category(
        id: nurseString,
        name: nurseString,
        svgPicture: nurseSvg,
      ),
      Category(
        id: dermatologyString,
        name: dermatologyString,
        svgPicture: dermatologySvg,
      ),
    ];

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
      Doctor(
        name: 'Bruno Rodrigues',
        profession: 'Physician',
        clinic: 'MP Shar hospital, Nairobi',
        rating: 5,
        reviews: 450,
      ),
      Doctor(
        name: 'Rian Ramires',
        profession: 'Nurse',
        clinic: 'St. Anne\'s hospital, Kisumu',
        rating: 5,
        reviews: 500,
      ),
      Doctor(
        name: 'Bruno Rodrigues',
        profession: 'Physician',
        clinic: 'MP Shar hospital, Nairobi',
        rating: 5,
        reviews: 450,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            splashColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  userSvg,
                  fit: BoxFit.cover,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
        title: const Text(fullNameHintString),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 130,
              width: double.infinity,
              child: CarouselBanner(),
            ),
            smallVerticalSizedBox,
            ICareSearchField(
              hintText: searchString,
              onSubmitted: (value) {},
            ),
            Row(
              children: [
                Text(
                  categoriesString,
                  style: heavySize14Text(
                    AppColors.blackColor,
                  ),
                ),
                const Spacer(),
                ICareTextButton(
                  onPressed: () {},
                  text: scrollString,
                  style: boldSize12Text(AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 75,
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: CategoryWidget(
                          id: category.id,
                          label: category.name,
                          assetName: category.svgPicture,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            // Wrap(
            //   spacing: 8,
            //   runSpacing: 5,
            //   children: [
            //     ...categories.map((category) {
            //       return CategoryWidget(
            //         label: category.name,
            //         assetName: category.svgPicture,
            //       );
            //     }).toList(),
            //   ],
            // ),
            Row(
              children: [
                Text(
                  doctorString,
                  style: heavySize14Text(
                    AppColors.blackColor,
                  ),
                ),
                const Spacer(),
                ICareTextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.listDoctors),
                  text: viewAllString,
                  style: boldSize12Text(AppColors.primaryColor),
                ),
              ],
            ),
            Column(
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
          ],
        ),
      )),
    );
  }
}
