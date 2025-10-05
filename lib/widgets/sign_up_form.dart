import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/screens/home_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText = true;
  bool obscureText2 = true;
  Icon suffixIcon = const Icon(Icons.visibility_off);
  Icon suffixIcon2 = const Icon(Icons.visibility_off);
  bool isLoading = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text,
            );
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Sign-up successful')));
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
          FirestoreService.addUser(
            uid: userCredential.user!.uid,
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMessage;
          switch (e.code) {
            case 'weak-password':
              errorMessage = 'The password provided is too weak.';
              break;
            case 'email-already-in-use':
              errorMessage = 'An account already exists for that email.';
              break;
            case 'invalid-email':
              errorMessage = 'Invalid email format.';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Email/password sign-up is disabled.';
              break;
            default:
              errorMessage = 'An error occurred: ${e.message}';
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
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
          Text('Name', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter your Name',
            labelText: 'Name',
            keyboardType: TextInputType.name,
            controller: nameController,
            onChanged: (value) {
              nameController.text = value;
            },
            validator: (value) => AppValidator.validateName(value),
          ),
          SizedBox(height: 16.0),
          Text('Email', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter your Email',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,

            validator: (value) => AppValidator.validateEmail(value),
          ),
          SizedBox(height: 16.0),

          Text('phone', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter phone number',
            labelText: 'Phone',
            keyboardType: TextInputType.phone,
            controller: phoneController,

            validator: (value) => AppValidator.validatePhone(value),
          ),
          SizedBox(height: 16.0),
          Text('Password', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter your password',
            labelText: 'Password',
            obscureText: obscureText,
            controller: passwordController,
            onChanged: (value) {
              passwordController.text = value;
            },
            validator: (value) => AppValidator.validatePassword(value),
            suffixIcon: IconButton(
              icon: obscureText ? suffixIcon : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
          ),
          SizedBox(height: 16.0),

          Text('Confirm Password', style: GoogleFonts.poppins()),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: 'Enter your password',
            labelText: 'Password',
            obscureText: obscureText2,
            controller: confirmPasswordController,
            onChanged: (value) {
              confirmPasswordController.text = value;
            },
            validator: (value) => AppValidator.validateConfirmPassword(
              value,
              passwordController.text,
            ),
            suffixIcon: IconButton(
              icon: obscureText2 ? suffixIcon2 : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText2 = !obscureText2;
                });
              },
            ),
          ),
          SizedBox(height: 24.0),
          CustomElevatedButton(
            onPressed: isLoading ? null : _signUp,
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'SignUp',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
