import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_search_field.dart';
import 'package:icare_mobile/presentation/profile/widgets/history_item_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          historyString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                smallHorizontalSizedBox,
                ICareSearchField(
                  hintText: 'search',
                  onSubmitted: (value) {},
                ),
                size15VerticalSizedBox,
                const HistoryItemWidget(
                  date: dateString,
                  time: '0600hrs',
                  name: fullNameHintString,
                  buttonText: reviewString,
                  clinic: 'Aga Khan',
                ),
                const HistoryItemWidget(
                  date: dateString,
                  time: '0600hrs',
                  name: fullNameHintString,
                  buttonText: reviewString,
                  clinic: 'Aga Khan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
