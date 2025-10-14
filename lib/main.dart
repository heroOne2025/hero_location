import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/firebase_options.dart';
import 'package:hero_location/provider/chanage_language_provider.dart';
import 'package:hero_location/widgets/my_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChanageLanguageProvider(),
      child: const MyApp(),
    ),
  );
}
