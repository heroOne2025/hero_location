import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
  });
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        floatingLabelStyle: TextStyle(color: AppColors.primryColor),
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
