import 'package:flutter/material.dart';

class ICareTextButton extends StatelessWidget {
  const ICareTextButton({
    super.key,
    this.buttonKey,
    required this.onPressed,
    required this.text,
    this.onLongPress,
    this.textColor,
    this.customChild, this.style,
  }) : assert(text != null);

  final Key? buttonKey;
  final Widget? customChild;
  final VoidCallback? onLongPress;
  final void Function()? onPressed;
  final String? text;
  final Color? textColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: buttonKey,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: customChild ??
          Text(
            text ?? '',
            style: style,
          ),
    );
  }
}
