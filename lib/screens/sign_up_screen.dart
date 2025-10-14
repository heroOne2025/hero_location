import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/widgets/custom_text_button.dart';
import 'package:hero_location/widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = 'sign_up';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70.0),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.createAccount,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                AppLocalizations.of(context)!.signUp,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              SignUpForm(),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.alreadyHaveAccount,
                    style: GoogleFonts.poppins(),
                  ),
                  CustomTextButton(
                    textButtonText: AppLocalizations.of(context)!.login,
                    onPressed: () {
                      Navigator.pop(context);
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
