import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
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
        showSnackBar('User not found');
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

      showSnackBar("Profile updated successfully");
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
        title: Text('Edit Profile', style: GoogleFonts.poppins()),
        backgroundColor: AppColors.primryColor,
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
                  'Welcome ${nameController.text.isEmpty ? 'User' : nameController.text}',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text('Name', style: GoogleFonts.poppins()),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Name',
                  labelText: 'Name',
                  keyboardType:
                      TextInputType.name, // 👈 تغيير من streetAddress إلى name
                  controller: nameController,
                  validator: AppValidator.validateName,
                ),
                const SizedBox(height: 8),
                Text('Email', style: GoogleFonts.poppins()),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Email',
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: AppValidator.validateEmail,
                  enabled: false, // 👈 الإيميل read-only
                ),
                const SizedBox(height: 16),
                Text('Phone Number', style: GoogleFonts.poppins()),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  validator: AppValidator.validatePhone,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomElevatedButton(
                    textOnButton: "Save Changes",
                    onPressed: isSaving ? null : saveUserData,
                    child: isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Save Changes',
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
