import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class ZeroAppointmentStateWidget extends StatelessWidget {
  const ZeroAppointmentStateWidget({
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: SvgPicture.asset(noNotificationSvg),
            ),
          ),
          mediumVerticalSizedBox,
          Text(
            text,
            style: boldSize18Text(AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
