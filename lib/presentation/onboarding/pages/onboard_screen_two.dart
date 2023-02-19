import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class OnboardScreenTwo extends StatelessWidget {
  const OnboardScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: SizedBox(
            height: 350,
            width: 300,
            child: SvgPicture.asset(doctorsSvg),
          ),
        ),
        const Spacer(),
        Text(
          onboardTwoString,
          textAlign: TextAlign.center,
          style: boldSize36Text(
            AppColors.primaryColor,
          ),
        ),
        const Spacer(),
        const Spacer(),
        const Spacer(),
      ],
    );
  }
}
