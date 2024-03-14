import 'package:flutter/material.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/onboarding/widgets/onboard_navigator.dart';
import 'package:icare_mobile/presentation/onboarding/widgets/onboarding_screen_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // controller for keeping track of what page we are in
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // page view
              PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = (index == 2);
                  });
                },
                children: [
                  ...onboardingItems.map(
                    (item) => OnboardScreenWidget(
                      svg: item['svg'] ?? '',
                      title: item['title'] ?? '',
                      description: item['description'] ?? '',
                    ),
                  ),
                ],
              ),
              OnboardNavigator(
                onLastPage: onLastPage,
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> onboardingItems = [
  {
    'svg': welcomeCatsSvg,
    'title': onboardOneTitle,
    'description': onboardOneDescriptionString,
  },
  {
    'svg': doctorsSvg,
    'title': onboardTwoTitle,
  },
  {
    'svg': workoutSvg,
    'title': onboardThreeTitle,
  },
];
