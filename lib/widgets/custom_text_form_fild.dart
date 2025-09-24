import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.obscureText,
  });
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintStyle: GoogleFonts.poppins(),
        hintText: hintText,
        floatingLabelStyle: GoogleFonts.poppins(color: AppColors.primryColor),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.primryColor),
        ),
        // label: Text(labelText, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
