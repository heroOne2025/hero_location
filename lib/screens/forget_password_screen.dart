import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_assets.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = '/forget_password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailControler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                Text('Email', style: GoogleFonts.poppins()),
                SizedBox(height: 8.0),
                CustomTextFormField(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailControler,
                  validator: (value) => AppValidator.validateEmail(value),
                ),
                SizedBox(height: 30.0),
                CustomElevatedButton(
                  textOnButton: 'Send',
                  onPressed: () async {
                    if (emailControler.text.isNotEmpty) {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: emailControler.text.trim(),
                        );
                        if (mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password reset email sent.'),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (mounted) {
                          String errorMessage;
                          switch (e.code) {
                            case 'invalid-email':
                              errorMessage = 'Invalid email format.';
                              break;
                            case 'user-not-found':
                              errorMessage = 'No user found for that email.';
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Unexpected error: $e')),
                          );
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
