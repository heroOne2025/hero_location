import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/widgets/custom_text_form_fild.dart';

import '../widgets/custom_elevated_button.dart';

class AddClintLocationScreen extends StatelessWidget {
  static String routeName = '/add_clint_location';
  const AddClintLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Client Location', style: GoogleFonts.poppins()),
        backgroundColor: AppColors.primryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                height: 175,
                width: 100,
                color: Colors.grey[400],
                child: const Center(
                  child: Icon(Icons.map, size: 50, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomElevatedButton(
                  textOnButton: 'Get Current Location',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              Text('name'),
              SizedBox(height: 8),
              CustomTextFormFiled(
                hintText: "Clint Name",
                labelText: 'name',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 10),
              Text('phone'),
              SizedBox(height: 8),
              CustomTextFormFiled(
                hintText: "Clint Phone",
                labelText: 'phone',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              Text('address'),
              SizedBox(height: 8),
              CustomTextFormFiled(
                hintText: "Clint Address",
                labelText: 'address',
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomElevatedButton(
                  textOnButton: 'Add Clint',
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
