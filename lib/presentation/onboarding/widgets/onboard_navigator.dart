import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardNavigator extends StatelessWidget {
  const OnboardNavigator({
    super.key,
    required this.onLastPage,
    required PageController controller,
  })  : _controller = controller;

  final bool onLastPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.9),
      child: onLastPage
          ? SizedBox(
              height: 48,
              width: double.infinity,
              child: ICareElevatedButton(
                text: getStartedString,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showTab', true);
                  if (!context.mounted) return;
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.tabEntry);
                },
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ICareTextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  text: skip,
                  textColor: AppColors.blackColor,
                  style: boldSize16Text(AppColors.blackColor),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.primaryColor.withOpacity(0.25),
                    dotWidth: 10,
                    dotHeight: 10,
                    radius: 10,
                  ),
                ),
                ICareTextButton(
                  onPressed: () {
                    _controller.nextPage(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.easeIn,
                    );
                  },
                  text: next,
                  textColor: AppColors.primaryColor,
                  style: boldSize16Text(AppColors.primaryColor),
                )
              ],
            ),
    );
  }
}
