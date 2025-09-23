import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/screens/forget_password_screen.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/screens/sing_up_screen.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_button.dart';
import 'package:hero_location/widgets/custom_text_form_fild.dart';

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
                  "Wolcome",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 80.0),
              Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50.0),
              Text('Email'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              Text('Password'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your password',
                labelText: 'Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              CustomTextButton(
                textButtonText: 'Forget Password?',
                onPressed: () {
                  Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                },
              ),
              SizedBox(height: 24.0),
              CustomElevatedButton(
                textOnButton: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: GoogleFonts.poppins()),
                  CustomTextButton(
                    textButtonText: 'Sing Up',
                    onPressed: () {
                      Navigator.pushNamed(context, SingUpScreen.routeName);
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
