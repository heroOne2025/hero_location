import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/helper/helper_fun.dart';
import 'package:hero_location/helper/show_snack_bar.dart';
import 'package:hero_location/screens/forget_password_screen.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/services/auth.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';

import 'custom_text_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  Icon suffixIcon = const Icon(Icons.visibility_off);
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Email', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter your email',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onChanged: (value) {
              emailController.text = value;
            },
            validator: (value) => AppValidator.validateEmail(value),
          ),
          SizedBox(height: 16.0),
          Text('Password', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter your password',
            labelText: 'Password',
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            onChanged: (value) {
              passwordController.text = value;
            },
            suffixIcon: IconButton(
              icon: obscureText ? suffixIcon : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            validator: (value) => AppValidator.validatePassword(value),
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
              if (formKey.currentState!.validate()) {
                try {
                  Auth.login(emailController.text, passwordController.text);

                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  showSnackBar(context, "Login successfully");
                } on FirebaseAuthException catch (e) {
                  loginCheck(e, context);
                }
              } else {
                autovalidateMode = AutovalidateMode.always;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
