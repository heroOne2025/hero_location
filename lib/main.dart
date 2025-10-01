import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/firebase_options.dart';
import 'package:hero_location/widgets/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase باستخدام الإعدادات المناسبة للمنصة
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
