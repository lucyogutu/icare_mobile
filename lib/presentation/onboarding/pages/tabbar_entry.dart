import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/onboarding/pages/login_page.dart';
import 'package:icare_mobile/presentation/onboarding/pages/register_page.dart';

class TabbarEntryPage extends StatefulWidget {
  const TabbarEntryPage({super.key});

  @override
  State<TabbarEntryPage> createState() => _TabbarEntryPageState();
}

class _TabbarEntryPageState extends State<TabbarEntryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                iCareString,
                style: heavySize20Text(AppColors.whiteColor),
              ),
              floating: true,
              pinned: true,
              backgroundColor: AppColors.primaryColor,
              bottom: TabBar(
                indicatorColor: AppColors.whiteColor,
                indicatorWeight: 3,
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: signInString,
                  ),
                  Tab(
                    text: signUpString,
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            LoginPage(
              signUp: () => _tabController.index = 1,
            ),
            RegisterPage(
              signIn: () => _tabController.index = 0,
            ),
          ],
        ),
      ),
    );
  }
}
