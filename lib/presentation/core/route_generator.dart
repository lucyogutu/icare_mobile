import 'package:flutter/material.dart';
import 'package:icare_mobile/presentation/core/bottom_nav_screen.dart';
import 'package:icare_mobile/presentation/core/routes.dart';
import 'package:icare_mobile/presentation/home/pages/book_page.dart';
import 'package:icare_mobile/presentation/home/pages/category_specific_page.dart';
import 'package:icare_mobile/presentation/home/pages/doctor_detail_page.dart';
import 'package:icare_mobile/presentation/home/pages/home_page.dart';
import 'package:icare_mobile/presentation/home/pages/list_doctors_page.dart';
import 'package:icare_mobile/presentation/home/pages/notification_page.dart';
import 'package:icare_mobile/presentation/onboarding/pages/forgot_password_page.dart';
import 'package:icare_mobile/presentation/onboarding/pages/tabbar_entry.dart';
import 'package:icare_mobile/presentation/profile/pages/about_page.dart';
import 'package:icare_mobile/presentation/profile/pages/edit_personal_details_page.dart';
import 'package:icare_mobile/presentation/profile/pages/history_page.dart';
import 'package:icare_mobile/presentation/profile/pages/personal_details_page.dart';
import 'package:icare_mobile/presentation/profile/pages/profile_page.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case AppRoutes.login:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => LoginPage(signUp: signUp),
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
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPasswordPage(),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfilePage(),
        );
      case AppRoutes.listDoctors:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ListDoctorsPage(),
        );
      case AppRoutes.bookAppointment:
        return MaterialPageRoute(
          builder: (BuildContext context) => BookPage(doctorName: args as String,),
        );
      case AppRoutes.bottomNav:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavScreen(),
        );
      case AppRoutes.personalDetails:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PersonalDetailsPage(),
        );
      case AppRoutes.editPersonalDetails:
        return MaterialPageRoute(
          builder: (BuildContext context) => const EditPersonalDetailsPage(),
        );
      case AppRoutes.history:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HistoryPage(),
        );
      case AppRoutes.about:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AboutPage(),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NotificationsPage(),
        );
      case AppRoutes.categoryDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            final categoryArgs = args as Map<String, String>;
            return CategorySpecificPage(
              id: categoryArgs['id']!,
              label: categoryArgs['label']!,
            );
          },
        );
      case AppRoutes.doctorDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            final docArgs = args as Map<String, String>;
            return DoctorDetailPage(
              doctorName: docArgs['doctorName']!,
              doctorProfession: docArgs['doctorProfession']!,
              doctorClinic: docArgs['doctorClinic']!,
            );
          },
        );
    }
    return null;
  }
}
