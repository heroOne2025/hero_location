import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';
import 'package:hero_location/core/utils/app_validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/change-password';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool isLoading = false;
  bool obscureOldPassword = true; // 👈 للتحكم في إظهار/إخفاء Old Password
  bool obscureNewPassword = true; // 👈 للتحكم في إظهار/إخفاء New Password
  bool obscureConfirmPassword =
      true; // 👈 للتحكم في إظهار/إخفاء Confirm Password

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showSnackBar(AppLocalizations.of(context)!.noUserSignedIn);
        setState(() => isLoading = false);
        return;
      }

      // التحقق من كلمة السر القديمة
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPasswordController.text.trim(),
      );
      await user.reauthenticateWithCredential(credential);

      // تحديث كلمة السر الجديدة
      await user.updatePassword(newPasswordController.text.trim());

      showSnackBar(AppLocalizations.of(context)!.passwordChangedSuccessfully);
      Navigator.pop(context);
    } catch (e) {
      String errorMessage = AppLocalizations.of(context)!.errorChangingPassword;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            errorMessage = AppLocalizations.of(context)!.oldPasswordIncorrect;
            break;
          case 'weak-password':
            errorMessage = AppLocalizations.of(context)!.newPasswordTooWeak;
            break;
          default:
            errorMessage = 'Error: ${e.message}';
        }
      }
      showSnackBar(errorMessage);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.changePassword,
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.changePassword,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.oldPassword,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.oldPassword,
                  labelText: AppLocalizations.of(context)!.oldPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      obscureOldPassword, // 👈 التحكم في الإظهار/الإخفاء
                  controller: oldPasswordController,
                  validator: (value) =>
                      AppValidator.validatePassword(context, value),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureOldPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => obscureOldPassword = !obscureOldPassword);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.newPassword,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.newPassword,
                  labelText: AppLocalizations.of(context)!.newPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      obscureNewPassword, // 👈 التحكم في الإظهار/الإخفاء
                  controller: newPasswordController,
                  validator: (value) =>
                      AppValidator.validatePassword(context, value),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => obscureNewPassword = !obscureNewPassword);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.confirmPassword,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      obscureConfirmPassword, // 👈 التحكم في الإظهار/الإخفاء
                  controller: confirmPasswordController,
                  validator: (value) => AppValidator.validateConfirmPassword(
                    context,
                    value,
                    newPasswordController.text,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(
                        () => obscureConfirmPassword = !obscureConfirmPassword,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: CustomElevatedButton(
                    onPressed: isLoading ? null : changePassword,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            AppLocalizations.of(context)!.changePassword,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
