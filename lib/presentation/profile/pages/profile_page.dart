import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/routes.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
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
              LayoutBuilder(
                builder: (context, constraints) {
                  return InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRoutes.personalDetails),
                    splashColor: AppColors.primaryColor,
                    child: Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: AppColors.primaryColorLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.3,
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
                            smallHorizontalSizedBox,
                            SizedBox(
                              width: constraints.maxWidth * 0.48,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fullNameHintString,
                                    style: boldSize18Text(AppColors.blackColor),
                                  ),
                                  smallVerticalSizedBox,
                                  Text(
                                    emailHintString,
                                    style: boldSize16Text(
                                        AppColors.lightBlackTextColor),
                                  ),
                                  smallVerticalSizedBox,
                                  Text(
                                    phoneNumberHintString,
                                    style:
                                        boldSize14Text(AppColors.greyTextColor),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(AppRoutes.editPersonalDetails),
                                splashColor: AppColors.primaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.primaryColor
                                        .withOpacity(0.25),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              verySmallVerticalSizedBox,
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              verySmallVerticalSizedBox,
              ProfileListItem(
                icon: Icons.favorite_border_outlined,
                title: favouriteString,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.favourites),
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
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.helpPage),
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
                    context: context,
                    title: logoutString,
                    content: logoutDescription,
                    yesButton: () => Navigator.of(context).pushNamed(AppRoutes.tabEntry),
                    buttonText: yesLogout,
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
                    context: context,
                    title: optOutString,
                    content: optoutDescription,
                    // should navigate user to tabEntry login screen and also delete user data from app
                    yesButton: () =>
                        Navigator.of(context).pushNamed(AppRoutes.tabEntry),
                    buttonText: yesOptout,
                  );
                },
              ),
              Divider(
                color: AppColors.primaryColor.withOpacity(0.25),
              ),
              largeVerticalSizedBox,
              Text(
                iCareString,
                style: heavySize16Text(AppColors.primaryColor),
              ),
              verySmallVerticalSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
