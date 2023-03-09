// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
// Project imports:
// Package imports:

class ICareTextFormField extends StatelessWidget {
  const ICareTextFormField({
    super.key,
    required this.label,
    this.textFieldKey,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.obscureText = false,
    this.maxLength,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    this.fillColor,
    this.readOnly,
    this.onTap,
    this.onSaved,
  });

  final String label;
  final Key? textFieldKey;
  final ValueChanged<String>? onChanged;
  final Function(String?)? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? initialValue;
  final AutovalidateMode autovalidateMode;
  final bool obscureText;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? suffixOnPressed;
  final VoidCallback? onTap;
  final Color? fillColor;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: textFieldKey,
      textInputAction: textInputAction,
      initialValue: initialValue,
      cursorColor: AppColors.primaryColor,
      readOnly: readOnly ?? false,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintTextColor),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.primaryColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixOnPressed,
          color: AppColors.primaryColor,
        ),
        labelText: label,
        //lable style
        labelStyle: normalSize14Text(AppColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      ),
      style: const TextStyle(
        color: AppColors.blackColor,
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
