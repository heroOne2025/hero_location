import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.textButtonText,
    this.onPressed,
  });
  final String textButtonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(alignment: Alignment.centerLeft),
      onPressed: onPressed,
      child: Text(
        textButtonText,
        style: GoogleFonts.poppins(color: AppColors.primryColor),
      ),
    );
  }
}
