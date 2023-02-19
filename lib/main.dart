import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/presentation/onboarding/pages/onboarding_page.dart';
import 'package:icare_mobile/presentation/profile/pages/about_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCare Patient',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primaryColor: AppColors.primaryColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: AppColors.whiteColor,
          secondary: AppColors.primaryColor,
          onSecondary: AppColors.whiteColor,
          error: AppColors.errorColor,
          onError: AppColors.whiteColor,
          background: AppColors.whiteColor,
          onBackground: AppColors.primaryColor,
          surface: AppColors.whiteColor,
          onSurface: AppColors.primaryColor,
        ),
      ),
      home: const OnboardingPage(),
    );
  }
}
