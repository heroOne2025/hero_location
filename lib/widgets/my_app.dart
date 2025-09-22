import 'package:flutter/material.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/screens/login_screen.dart';
import 'package:hero_location/screens/sing_up_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        SingUpScreen.routeName: (context) => SingUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
