import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/screens/Add_clint_location_screen.dart';
import 'package:hero_location/screens/app_language_screen.dart';
import 'package:hero_location/screens/change_password_screen.dart';
import 'package:hero_location/screens/edit_profile_screen.dart';
import 'package:hero_location/screens/forget_password_screen.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/screens/login_screen.dart';
import 'package:hero_location/screens/sign_up_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddClintLocationScreen.routeName: (context) => AddClintLocationScreen(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),
        ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
        AppLanguage.routeName: (context) => AppLanguage(),
      },
    );
  }
}
