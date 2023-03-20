import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/user.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
import 'package:icare_mobile/presentation/profile/widgets/profile_list_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User>? _getProfileDetails;
  Future<User>? _logoutUser;
  Future<User>? _optoutUser;

  @override
  void initState() {
    super.initState();
    _getProfileDetails = getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          profileString,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () =>
        //         Navigator.of(context).pushNamed(AppRoutes.notifications),
        //     icon: const Icon(Icons.notifications_none_outlined),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: AppColors.primaryColorLight,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return FutureBuilder(
                        future: _getProfileDetails,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            errorAlert(context);
                          }
                          return InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AppRoutes.personalDetails),
                            splashColor: AppColors.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  // Container(
                                  //   width: constraints.maxWidth * 0.3,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(100),
                                  //     color: AppColors.primaryColor
                                  //         .withOpacity(0.25),
                                  //   ),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(16.0),
                                  //     child: FittedBox(
                                  //       child: SvgPicture.asset(userSvg),
                                  //     ),
                                  //   ),
                                  // ),
                                  // smallHorizontalSizedBox,
                                  SizedBox(
                                    width: constraints.maxWidth * 0.78,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              size: 20,
                                              color: AppColors.primaryColor,
                                            ),
                                            smallHorizontalSizedBox,
                                            Text(
                                              '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                                              style: boldSize18Text(
                                                  AppColors.blackColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.mail,
                                              size: 20,
                                              color: AppColors.primaryColor,
                                            ),
                                            smallHorizontalSizedBox,
                                            Text(
                                              snapshot.data!.email!,
                                              style: boldSize16Text(AppColors
                                                  .lightBlackTextColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              size: 20,
                                              color: AppColors.primaryColor,
                                            ),
                                            smallHorizontalSizedBox,
                                            Text(
                                              '0${snapshot.data!.phoneNumber}',
                                              style: boldSize14Text(
                                                  AppColors.greyTextColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      onTap: () =>
                                          Navigator.of(context).pushNamed(
                                        AppRoutes.editPersonalDetails,
                                        arguments: _getProfileDetails,
                                      ),
                                      splashColor: AppColors.primaryColor,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                          );
                        },
                      );
                    },
                  ),
                ),
                verySmallVerticalSizedBox,
                Divider(
                  color: AppColors.primaryColor.withOpacity(0.25),
                ),
                // verySmallVerticalSizedBox,
                // ProfileListItem(
                //   icon: Icons.favorite_border_outlined,
                //   title: favouriteString,
                //   onTap: () =>
                //       Navigator.of(context).pushNamed(AppRoutes.favourites),
                // ),
                // Divider(
                //   color: AppColors.primaryColor.withOpacity(0.25),
                // ),
                verySmallVerticalSizedBox,
                ProfileListItem(
                  icon: Icons.history,
                  title: historyString,
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.history),
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
                      yesButton: () {
                        if (_logoutUser == null) {
                          _logoutUser = logoutUser();
                          Navigator.of(context).pushNamed(AppRoutes.tabEntry);
                        } else {
                          FutureBuilder(
                            future: _logoutUser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const SnackBar(
                                  content: Text('Logout successfull'),
                                );
                              }
                              if (snapshot.hasError) {
                                errorAlert(context);
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        }
                      },
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
                      yesButton: () {
                        if (_optoutUser == null) {
                          _optoutUser = optoutUser();
                          Navigator.of(context).pushNamed(AppRoutes.tabEntry);
                        } else {
                          FutureBuilder(
                            future: _optoutUser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const SnackBar(
                                  content: Text('optOut successfull'),
                                );
                              }
                              if (snapshot.hasError) {
                                errorAlert(context);
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        }
                      },
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
      ),
    );
  }
}
