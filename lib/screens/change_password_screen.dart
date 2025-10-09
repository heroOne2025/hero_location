import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        showSnackBar('No user is signed in');
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

      showSnackBar('Password changed successfully');
      Navigator.pop(context);
    } catch (e) {
      String errorMessage = 'Error changing password';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            errorMessage = 'Old password is incorrect';
            break;
          case 'weak-password':
            errorMessage = 'New password is too weak';
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
        title: Text('Change Password', style: GoogleFonts.poppins()),
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
                  'Change Password',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text('Old Password', style: GoogleFonts.poppins()),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Old Password',
                  labelText: 'Old Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      obscureOldPassword, // 👈 التحكم في الإظهار/الإخفاء
                  controller: oldPasswordController,
                  validator: (value) => AppValidator.validatePassword(value),
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
                Text('New Password', style: GoogleFonts.poppins()),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'New Password',
                  labelText: 'New Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      obscureNewPassword, // 👈 التحكم في الإظهار/الإخفاء
                  controller: newPasswordController,
                  validator: (value) => AppValidator.validatePassword(value),
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
                Text('Confirm Password', style: GoogleFonts.poppins()),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      obscureConfirmPassword, // 👈 التحكم في الإظهار/الإخفاء
                  controller: confirmPasswordController,
                  validator: (value) => AppValidator.validateConfirmPassword(
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
                    textOnButton: "Change Password",
                    onPressed: isLoading ? null : changePassword,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Change Password',
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
