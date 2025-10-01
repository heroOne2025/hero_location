import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.selectedIndex, this.onTap});
  final int selectedIndex;
  final void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: selectedIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: GoogleFonts.poppins(),
      onTap: onTap,

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'settings',
        ),
      ],
    );
  }
}
