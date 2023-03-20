import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.userProfileImage,
    required this.onCameraPressed,
    required this.onGalleryPressed,
  });

  final File? userProfileImage;
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPickImageOptions(context);
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: (userProfileImage != null)
                ? ClipOval(
                    child: Image.file(userProfileImage!),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      userSvg,
                      fit: BoxFit.cover,
                      color: AppColors.primaryColor,
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.primaryColorLight,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.add_a_photo,
                  size: 15,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PersistentBottomSheetController<dynamic> showPickImageOptions(
      BuildContext context) {
    return showBottomSheet(
      context: context,
      elevation: 10,
      backgroundColor: AppColors.primaryColor,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Camera',
                    style: boldSize16Text(AppColors.whiteColor),
                  ),
                  onTap: onCameraPressed,
                ),
                smallVerticalSizedBox,
                ListTile(
                  leading: const Icon(
                    Icons.photo,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Gallery',
                    style: boldSize16Text(AppColors.whiteColor),
                  ),
                  onTap: onGalleryPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
