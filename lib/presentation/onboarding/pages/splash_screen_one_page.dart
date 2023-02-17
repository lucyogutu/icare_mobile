import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class SplashScreenOne extends StatelessWidget {
  const SplashScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Image.asset(icareLogoDark)),
      ),
    );
  }
}
