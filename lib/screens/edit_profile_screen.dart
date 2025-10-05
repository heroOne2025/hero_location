import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit-profile';
  const EditProfileScreen({super.key});

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
                'Welcome Abdalrahman',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text('Name', style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: 'Name',
                labelText: 'name',
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 8),
              Text('Email', style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: 'email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              Text('Phone Number', style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: 'phone number',
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: CustomElevatedButton(
                  textOnButton: "Save Changes",
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
