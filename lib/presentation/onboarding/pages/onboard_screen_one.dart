import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class OnboardScreenOne extends StatelessWidget {
  const OnboardScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: SvgPicture.asset(welcomeCatsSvg),
        ),
        const Spacer(),
        Text(
          welcomeDescriptionString,
          textAlign: TextAlign.center,
          style: boldSize36Text(
            AppColors.primaryColor,
          ),
        ),
        const Spacer(),
        Text(
          onboardOneString,
          textAlign: TextAlign.center,
          style: normalSize18Text(
            AppColors.blackColor,
          ),
        ),
        const Spacer(),
        const Spacer(),
      ],
    );
  }
}
