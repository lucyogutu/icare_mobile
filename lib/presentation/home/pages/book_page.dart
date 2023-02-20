import 'package:flutter/material.dart';
import 'package:icare_mobile/presentation/core/routes.dart';

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
          children: const [],
        ),
      )),
    );
  }
}
