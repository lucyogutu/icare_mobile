import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';

class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.doctorName,
  });

  final String doctorName;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.doctorName,
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
        
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [],
        ),
      )),
    );
  }
}
