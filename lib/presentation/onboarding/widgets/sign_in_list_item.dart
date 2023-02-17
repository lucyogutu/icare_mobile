import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';

class SignInListItem extends StatelessWidget {
  const SignInListItem({
    super.key,
    required this.svgValue,
    required this.title,
    required this.onTap,
    this.buttonKey,
  });

  final String svgValue;
  final String title;
  final VoidCallback onTap;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: buttonKey,
      onTap: onTap,
      radius: 10.0,
      splashColor: AppColors.primaryColor,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        tileColor: AppColors.whiteColor,
        leading: SvgPicture.asset(svgValue),
        title: Text(
          title,
          style: boldSize14Text(
            AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
