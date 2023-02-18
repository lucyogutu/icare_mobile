import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';

class ZeroStateWidget extends StatelessWidget {
  const ZeroStateWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(noNotificationSvg),
          ),
          mediumVerticalSizedBox,
          Text(
            text,
            style: boldSize18Text(AppColors.primaryColor),
          ),
          mediumVerticalSizedBox,
          const SizedBox(
            height: 40,
            width: double.infinity,
            child: ICareElevatedButton(text: okayThanksString),
          )
        ],
      ),
    );
  }
}
