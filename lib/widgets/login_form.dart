import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/screens/forget_password_screen.dart';
import 'package:hero_location/screens/home_screen.dart';
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
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.loginSuccessful),
            ),
          );
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMessage;
          switch (e.code) {
            case 'user-not-found':
              errorMessage = AppLocalizations.of(
                context,
              )!.noUserFoundForThatEmail;
              break;
            case 'wrong-password':
              errorMessage = AppLocalizations.of(context)!.wrongPassword;
              break;
            case 'invalid-email':
              errorMessage = AppLocalizations.of(context)!.invalidEmailFormat;
              break;
            case 'user-disabled':
              errorMessage = AppLocalizations.of(context)!.userDisabled;
              break;
            case 'invalid-credential':
            case 'invalid-verification-code':
            case 'invalid-verification-id':
              errorMessage = AppLocalizations.of(context)!.invalidCredential;
              break;
            default:
              errorMessage = AppLocalizations.of(context)!.unknownError;
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
          Text(
            AppLocalizations.of(context)!.email,
            style: GoogleFonts.poppins(),
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.enterYourEmail,
            labelText: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,

            validator: (value) => AppValidator.validateEmail(context, value),
          ),
          SizedBox(height: 16.0),
          Text(
            AppLocalizations.of(context)!.password,
            style: GoogleFonts.poppins(),
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.enterYourPassword,
            labelText: AppLocalizations.of(context)!.password,
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,

            suffixIcon: IconButton(
              icon: obscureText ? suffixIcon : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            validator: (value) => AppValidator.validatePassword(context, value),
          ),
          CustomTextButton(
            textButtonText: AppLocalizations.of(context)!.forgetPassword,
            onPressed: () {
              Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
            },
          ),
          SizedBox(height: 24.0),
          CustomElevatedButton(
            onPressed: isLoading ? null : _login,
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    AppLocalizations.of(context)!.login,
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
