import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardNavigator extends StatelessWidget {
  const OnboardNavigator({
    Key? key,
    required this.onLastPage,
    required PageController controller,
  }) : _controller = controller, super(key: key);

  final bool onLastPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.9),
      child: onLastPage
          ? const SizedBox(
              height: 40,
              width: double.infinity,
              child: ICareElevatedButton(
                text: getStartedString,
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
