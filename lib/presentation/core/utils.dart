import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';

// utils.dart, a class holding common methods

// alert dialog for logout and optout options
Future<dynamic> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback yesButton,
  required String buttonText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ICareTextButton(
            onPressed: () => Navigator.of(context).pop(),
            text: noCancel,
            style: boldSize14Text(AppColors.primaryColor),
          ),
          ICareTextButton(
            onPressed: yesButton,
            text: buttonText,
            style: boldSize14Text(AppColors.redColor),
          ),
        ],
      );
    },
  );
}

// review bottom sheet
PersistentBottomSheetController<dynamic> showReviewBottomSheet(
    BuildContext context, String name) {
  return showBottomSheet(
      context: context,
      elevation: 10,
      backgroundColor: AppColors.primaryColorLight,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewString,
                  style: boldSize18Text(AppColors.blackColor),
                ),
                smallVerticalSizedBox,
                Text(
                  name,
                  style: boldSize16Text(
                    AppColors.blackColor,
                  ),
                ),
                smallVerticalSizedBox,
                Row(
                  children: const [
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                    Icon(Icons.star_outline),
                  ],
                ),
                smallVerticalSizedBox,
                TextField(
                  maxLines: 4,
                  minLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    hintText: 'Leave a review',
                    hintStyle: const TextStyle(
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ),
                mediumVerticalSizedBox,
                const SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ICareElevatedButton(text: reviewString),
                ),
              ],
            ),
          ),
        );
      });
}
