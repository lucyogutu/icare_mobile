import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/home/pages/book_page.dart';
import 'package:icare_mobile/presentation/home/pages/home_page.dart';
import 'package:icare_mobile/presentation/profile/pages/profile_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Widget> _pages = const [
    HomePage(),
    BookPage(doctorName: '',), //replace with appointment page
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: AppColors.primaryColorLight,
          backgroundColor: AppColors.whiteColor,
          labelTextStyle: MaterialStatePropertyAll(
            heavySize12Text(AppColors.primaryColor),
          ),
          elevation: 10,
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: _selectedPageIndex,
          onDestinationSelected: _selectPage,
          animationDuration: const Duration(seconds: 2),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: homeString,
            ),
            NavigationDestination(
              icon: Icon(Icons.watch_later_outlined),
              selectedIcon: Icon(Icons.watch_later),
              label: appointmentString,
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: profileString,
            ),
          ],
        ),
      ),
    );
  }
}
