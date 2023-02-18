import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.label,
    required this.assetName,
    this.onTap,
  });

  final String label;
  final String assetName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.primaryColor,
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(
                color: AppColors.primaryColorLight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FittedBox(
                child: SvgPicture.asset(
                  assetName,
                ),
              ),
            ),
          ),
          verySmallVerticalSizedBox,
          Text(
            label,
            textAlign: TextAlign.center,
            style: normalSize12Text(AppColors.blackColor),
          )
        ],
      ),
    );
  }
}
