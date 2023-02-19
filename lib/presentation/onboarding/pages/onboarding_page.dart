import 'package:flutter/material.dart';
import 'package:icare_mobile/presentation/onboarding/pages/onboard_screen_one.dart';
import 'package:icare_mobile/presentation/onboarding/pages/onboard_screen_three.dart';
import 'package:icare_mobile/presentation/onboarding/pages/onboard_screen_two.dart';
import 'package:icare_mobile/presentation/onboarding/widgets/onboard_navigator.dart';

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
      body: Padding(
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
              children: const [
                OnboardScreenOne(),
                OnboardScreenTwo(),
                OnboardScreenThree(),
              ],
            ),
            OnboardNavigator(
              onLastPage: onLastPage,
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
