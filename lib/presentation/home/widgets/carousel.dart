import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
        CarouselContainer(
          title: 'Limit Unhealthy Foods and Eat Healthy Meals',
          content:
              'Eat breakfast and choose a nutritious meal with more protein and fiber and less fat, sugar, and calories.',
          svg: medicineSvg,
        ),
        CarouselContainer(
          title: 'Measure and Watch Your Weight',
          content:
              'Keeping track of your body weight on a daily or weekly basis will help you see what you’re losing and/or what you’re gaining.',
          svg: workoutSvg,
        ),
        CarouselContainer(
          title: 'Drink Water and Stay Hydrated',
          content:
              'Drink water regularly to stay healthy, and Limit Sugared Beverages',
          svg: refreshingBeverage,
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 1.0,
        autoPlayInterval: const Duration(seconds: 20),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
      ),
    );
  }
}

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({
    Key? key,
    required this.title,
    required this.content,
    required this.svg,
  }) : super(key: key);

  final String title;
  final String content;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: AppColors.primaryColorLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: boldSize16Text(AppColors.blackColor),
            ),
            smallVerticalSizedBox,
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.55,
                    child: Text(content),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxWidth * 0.25,
                    child: FittedBox(
                      child: SvgPicture.asset(svg),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
