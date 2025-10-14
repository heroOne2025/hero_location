import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/screens/sign_up_screen.dart';
import 'package:hero_location/widgets/custom_text_button.dart';
import 'package:hero_location/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.welcome,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 80.0),
              Text(
                AppLocalizations.of(context)!.login,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50.0),
              LoginForm(),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAccount,
                    style: GoogleFonts.poppins(),
                  ),
                  CustomTextButton(
                    textButtonText: AppLocalizations.of(context)!.signUp,
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
