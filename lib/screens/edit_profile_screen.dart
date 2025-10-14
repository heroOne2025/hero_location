import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';
import 'package:hero_location/core/utils/app_validator.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> loadUserData() async {
    setState(() => isLoading = true);
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirestoreService.getUser(userId);

      print('User data: ${doc.data()}'); // 👈 للتحقق من الداتا

      if (doc.exists) {
        final data = doc.data()!;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
      } else {
        showSnackBar(AppLocalizations.of(context)!.userNotFound);
      }
    } catch (e) {
      showSnackBar('Error loading user data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> saveUserData() async {
    if (!formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => isSaving = true);
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirestoreService.updateUser(userId, {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(), // 👈 إضافة وقت التحديث
      });

      showSnackBar(AppLocalizations.of(context)!.profileUpdatedSuccessfully);
      Navigator.pop(context);
    } catch (e) {
      showSnackBar("Error updating profile: $e");
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editProfile,
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
                  '${AppLocalizations.of(context)!.welcome} ${nameController.text.isEmpty ? 'User' : nameController.text}',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.name,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.name,
                  labelText: AppLocalizations.of(context)!.name,
                  keyboardType:
                      TextInputType.name, // 👈 تغيير من streetAddress إلى name
                  controller: nameController,
                  validator: (value) =>
                      AppValidator.validateName(context, value),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.email,
                  labelText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) =>
                      AppValidator.validateEmail(context, value),
                  enabled: false, // 👈 الإيميل read-only
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.phoneNumber,
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  validator: (value) =>
                      AppValidator.validatePhone(context, value),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomElevatedButton(
                    onPressed: isSaving ? null : saveUserData,
                    child: isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            AppLocalizations.of(context)!.saveChanges,
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
