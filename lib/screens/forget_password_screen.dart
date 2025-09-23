import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_assets.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_fild.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = '/forget_password';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50.0),
              Image.asset(
                AppAssets.forgetPassword,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  "Forget Your Password?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Text('Email'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
              SizedBox(height: 30.0),
              CustomElevatedButton(
                textOnButton: 'Send',
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
