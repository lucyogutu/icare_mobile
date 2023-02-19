import 'package:flutter/material.dart';
import 'package:icare_mobile/presentation/core/routes.dart';
import 'package:icare_mobile/presentation/home/pages/home_page.dart';
import 'package:icare_mobile/presentation/onboarding/pages/tabbar_entry.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      // case AppRoutes.login:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const LoginPage(),
      //   );
      // case AppRoutes.register:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const RegisterPage(),
      //   );
      case AppRoutes.tabEntry:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TabbarEntryPage(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        );
    }
    return null;
  }
}
