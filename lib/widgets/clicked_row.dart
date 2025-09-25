import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClickedRow extends StatelessWidget {
  const ClickedRow({
    super.key,
    required this.avatar,
    required this.text,
    this.onTap,
  });
  final String avatar;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(avatar),
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 24),
        ],
      ),
    );
  }
}
