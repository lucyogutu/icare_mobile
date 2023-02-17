import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';

class ICareCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ICareCustomAppBar({
    super.key,
    this.leadingWidget,
    this.title,
    this.trailingWidget,
    this.showNotificationIcon = false,
    this.showShadow = true,
    this.showBackButton = true,
  });

  final Widget? leadingWidget;
  final String? title;
  final Widget? trailingWidget;
  final bool showNotificationIcon;
  final bool showShadow;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: showShadow
              ? <BoxShadow>[
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0.35, 0),
                    color: Colors.grey.withOpacity(0.2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            leadingWidget!,
            Flexible(
              child: Text(
                title ?? '',
                style: boldSize16Text().copyWith(color: AppColors.blackColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
