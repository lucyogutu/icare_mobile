import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/presentation/core/route_generator.dart';
import 'package:icare_mobile/presentation/home/pages/home_page.dart';
import 'package:icare_mobile/presentation/onboarding/pages/onboarding_page.dart';
import 'package:icare_mobile/presentation/onboarding/pages/tabbar_entry.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.showTab,
    required this.showHome,
  });

  final bool showTab;
  final bool showHome;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCare',
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
      home: showTab
          ? const TabbarEntryPage()
          : showHome
              ? const HomePage()
              : const OnboardingPage(),
      onGenerateRoute: GenerateRoute.onGenerateRoute,
    );
  }
}