import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';

class OnboardScreenThree extends StatelessWidget {
  const OnboardScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: SizedBox(
                height: 350,
                width: 300,
                child: SvgPicture.asset(workoutSvg),
              ),
            ),
            Text(
              onboardThreeString,
              textAlign: TextAlign.center,
              style: boldSize36Text(
                AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 40,
              width: double.infinity,
              child: ICareElevatedButton(
                text: getStartedString,
              ),
            )
          ],
        ),
      ),
    );
  }
}
