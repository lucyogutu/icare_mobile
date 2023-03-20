import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.25),
        radius: 20,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
            child: Icon(
              icon,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: boldSize16Text(AppColors.blackColor),
      ),
      trailing: const Icon(Icons.arrow_forward_rounded),
      onTap: onTap,
    );
  }
}
