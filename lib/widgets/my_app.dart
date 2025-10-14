import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/provider/chanage_language_provider.dart';
import 'package:hero_location/screens/Add_clint_location_screen.dart';
import 'package:hero_location/screens/app_language_screen.dart';
import 'package:hero_location/screens/change_password_screen.dart';
import 'package:hero_location/screens/client_details_screen.dart';
import 'package:hero_location/screens/edit_profile_screen.dart';
import 'package:hero_location/screens/forget_password_screen.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/screens/login_screen.dart';
import 'package:hero_location/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChanageLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(provider.currentLanguage),
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

        ClientDetailsScreen.routeName: (context) {
          final clientId =
              ModalRoute.of(context)!.settings.arguments as String?;
          return ClientDetailsScreen(clientId: clientId!);
        },
      },
    );
  }
}
