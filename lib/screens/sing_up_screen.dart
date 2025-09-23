import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/screens/login_screen.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_button.dart';
import 'package:hero_location/widgets/custom_text_form_fild.dart';

class SingUpScreen extends StatelessWidget {
  static String routeName = '/sing_up';
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70.0),
              Center(
                child: Text(
                  "create an account",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Sing Up',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              Text('Name'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your Name',
                labelText: 'Name',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16.0),
              Text('Email'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your Email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),

              Text('phone'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter phone number',
                labelText: 'Phone',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
              Text('Password'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your password',
                labelText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 16.0),

              Text('Confirm Password'),
              SizedBox(height: 8.0),
              CustomTextFormFiled(
                hintText: 'Enter your password',
                labelText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              CustomElevatedButton(
                textOnButton: 'Sing Up',
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Alrady have an account?", style: GoogleFonts.poppins()),
                  CustomTextButton(
                    textButtonText: 'Login',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
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
