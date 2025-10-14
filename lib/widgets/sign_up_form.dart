import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/l10n/app_localizations.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.signUpSuccessful),
            ),
          );
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
              errorMessage = AppLocalizations.of(context)!.weakPassword;
              break;
            case 'email-already-in-use':
              errorMessage = AppLocalizations.of(context)!.emailAlreadyInUse;
              break;
            case 'invalid-email':
              errorMessage = AppLocalizations.of(context)!.invalidEmailFormat;
              break;
            case 'operation-not-allowed':
              errorMessage = AppLocalizations.of(context)!.userDisabled;
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
          Text(
            AppLocalizations.of(context)!.name,
            style: GoogleFonts.poppins(),
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.enterYourName,
            labelText: AppLocalizations.of(context)!.name,
            keyboardType: TextInputType.name,
            controller: nameController,
            onChanged: (value) {
              nameController.text = value;
            },
            validator: (value) => AppValidator.validateName(context, value),
          ),
          SizedBox(height: 16.0),
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
            AppLocalizations.of(context)!.phoneNumber,
            style: GoogleFonts.poppins(),
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.enterPhoneNumber,
            labelText: AppLocalizations.of(context)!.phoneNumber,
            keyboardType: TextInputType.phone,
            controller: phoneController,

            validator: (value) => AppValidator.validatePhone(context, value),
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
            controller: passwordController,
            onChanged: (value) {
              passwordController.text = value;
            },
            validator: (value) => AppValidator.validatePassword(context, value),
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

          Text(
            AppLocalizations.of(context)!.confirmPassword,
            style: GoogleFonts.poppins(),
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.enterYourPassword,
            labelText: AppLocalizations.of(context)!.password,
            obscureText: obscureText2,
            controller: confirmPasswordController,
            onChanged: (value) {
              confirmPasswordController.text = value;
            },
            validator: (value) => AppValidator.validateConfirmPassword(
              context,
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
                    AppLocalizations.of(context)!.signUp,
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
