import 'package:flutter/material.dart';
import 'package:hero_location/screens/Add_clint_location_screen.dart';
import 'package:hero_location/screens/change_language_screen.dart';
import 'package:hero_location/screens/change_password_screen.dart';
import 'package:hero_location/screens/edit_profile_screen.dart';
import 'package:hero_location/screens/forget_password_screen.dart';
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
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        SingUpScreen.routeName: (context) => SingUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddClintLocationScreen.routeName: (context) => AddClintLocationScreen(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),
        ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
        ChangeLanguageScreen.routeName: (context) => ChangeLanguageScreen(),
      },
    );
  }
}
