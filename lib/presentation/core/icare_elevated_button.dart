import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/text_styles.dart';

class ICareElevatedButton extends StatelessWidget {
  const ICareElevatedButton({
    super.key,
    this.onPressed,
    this.borderColor,
    this.buttonColor,
    this.buttonKey,
    this.customChild,
    this.customElevation,
    this.customPadding,
    this.customRadius,
    this.onLongPress,
    required this.text,
    this.textColor,
    this.textStyle,
  });

  final void Function()? onPressed;
  final Color? borderColor;
  final Color? buttonColor;
  final Key? buttonKey;
  final Widget? customChild;
  final double? customElevation;
  final EdgeInsets? customPadding;
  final double? customRadius;
  final void Function()? onLongPress;
  final String text;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      key: buttonKey,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      elevation: customElevation ?? 0,
      onPressed: onPressed,
      onLongPress: () {
        onLongPress!();
      },
      padding: customPadding ?? const EdgeInsets.all(10),
      fillColor: buttonColor ?? Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(customRadius ?? 5.0),
        side: BorderSide(
          color: borderColor ?? Theme.of(context).primaryColor,
          width: borderColor != null ? 1 : 0,
        ),
      ),
      child: customChild ??
          Text(
            text,
            style: textStyle ?? boldSize16Text(textColor ?? Colors.white),
          ),
      
    );
  }
}
