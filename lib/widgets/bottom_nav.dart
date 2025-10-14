import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/l10n/app_localizations.dart';

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

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: AppLocalizations.of(context)!.settings,
        ),
      ],
    );
  }
}
