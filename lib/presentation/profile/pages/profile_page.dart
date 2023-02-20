import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/routes.dart';
import 'package:icare_mobile/presentation/profile/widgets/profile_list_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          profileString,
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              smallVerticalSizedBox,
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.primaryColor.withOpacity(0.25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FittedBox(
                      child: SvgPicture.asset(userSvg),
                    ),
                  ),
                ),
              ),
              smallVerticalSizedBox,
              Text(
                fullNameHintString,
                style: boldSize18Text(AppColors.blackColor),
              ),
              verySmallVerticalSizedBox,
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.person_outline,
                title: personalDetailsString,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.personalDetails),
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.favorite_border_outlined,
                title: favouriteString,
                onTap: () {},
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.history,
                title: historyString,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.history),
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.info_outline,
                title: aboutString,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.about),
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.help_outline,
                title: helpString,
                onTap: () {},
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.logout,
                title: logoutString,
                onTap: () {
                  showAlertDialog(
                    context,
                    logoutString,
                    logoutDescription,
                    () => Navigator.of(context).pushNamed(AppRoutes.tabEntry),
                  );
                },
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.delete_outline,
                title: optOutString,
                onTap: () {
                  showAlertDialog(
                    context,
                    optOutString,
                    optoutDescription,
                    // should navigate user to tabEntry login screen and also delete user data from app
                    () => Navigator.of(context).pushNamed(AppRoutes.tabEntry), 
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAlertDialog(BuildContext context, String title,
      String content, VoidCallback yesButton) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ICareTextButton(
              onPressed: () => Navigator.of(context).pop(),
              text: noCancel,
              style: boldSize14Text(AppColors.primaryColor),
            ),
            ICareTextButton(
              onPressed: yesButton,
              text: yesLogout,
              style: boldSize14Text(AppColors.redColor),
            ),
          ],
        );
      },
    );
  }
}
