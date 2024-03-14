import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:icare_mobile/firebase_options.dart';
import 'package:icare_mobile/presentation/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final showTab = prefs.getBool('showTab') ?? false;
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(
    MyApp(
      showTab: showTab,
      showHome: showHome,
    ),
  );
}

