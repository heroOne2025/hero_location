import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_fild.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Change Password',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text('old password', style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              CustomTextFormFiled(
                hintText: 'old password',
                labelText: 'old password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(height: 8),
              Text('new password', style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              CustomTextFormFiled(
                hintText: 'new password',
                labelText: 'new password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(height: 16),
              Text('Confirm Password', style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              CustomTextFormFiled(
                hintText: 'Confirm Password',
                labelText: 'Confirm Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: CustomElevatedButton(
                  textOnButton: "Change Password",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
