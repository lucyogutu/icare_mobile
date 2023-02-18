import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';

class OnboardNavigator extends StatelessWidget {
  const OnboardNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ICareTextButton(
          onPressed: () {},
          text: skip,
          textColor: AppColors.blackColor,
          style: boldSize16Text(AppColors.primaryColor),
        ),
        const Spacer(),
        ICareTextButton(
          onPressed: () {},
          text: next,
          textColor: AppColors.primaryColor,
          style: boldSize16Text(AppColors.primaryColor),
        ),
      ],
    );
  }
}
