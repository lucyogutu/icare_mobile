import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';

class ICareSearchField extends StatelessWidget {
  ICareSearchField({
    super.key,
    this.searchKey,
    this.hintText,
    this.buttonKey,
    this.maxLines,
    this.minLines,
    required this.onSubmitted,
    this.onChanged,
  });

  final Key? searchKey;
  final Key? buttonKey;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      key: searchKey,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.primaryColorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.greyTextColor),
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
        suffixIcon: IconButton(
          key: buttonKey,
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
