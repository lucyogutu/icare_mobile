import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';

class OnboardScreenWidget extends StatelessWidget {
  const OnboardScreenWidget({
    super.key,
    required this.svg,
    required this.title,
    this.description,
  });

  final String svg;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: SvgPicture.asset(svg),
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: boldSize36Text(
            AppColors.primaryColor,
          ),
        ),
        mediumVerticalSizedBox,
        description != null
            ? Text(
                description!,
                textAlign: TextAlign.center,
                style: normalSize18Text(
                  AppColors.blackColor,
                ),
              )
            : const SizedBox(),
        const Spacer(),
        const Spacer(),
      ],
    );
  }
}
