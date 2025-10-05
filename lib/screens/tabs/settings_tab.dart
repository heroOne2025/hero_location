import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_assets.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/screens/app_language_screen.dart';
import 'package:hero_location/screens/change_password_screen.dart';
import 'package:hero_location/screens/edit_profile_screen.dart';
import 'package:hero_location/screens/login_screen.dart';
import 'package:hero_location/widgets/clicked_row.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 40,
        children: [
          SizedBox(height: 50),
          ClickedRow(
            avatar: AppAssets.profileAvatar,
            text: 'Edit Profile',
            onTap: () {
              Navigator.pushNamed(context, EditProfileScreen.routeName);
            },
          ),
          ClickedRow(
            avatar: AppAssets.changePassword,
            text: 'Change Password',
            onTap: () {
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),
          ClickedRow(
            avatar: AppAssets.changeLanguage,
            text: 'App Language',
            onTap: () {
              Navigator.pushNamed(context, AppLanguage.routeName);
            },
          ),
          ClickedRow(
            avatar: AppAssets.logout,
            text: 'Logout',
            onTap: () async {
              AwesomeDialog(
                context: context,
                autoDismiss: true,
                dialogType: DialogType.warning,
                body: Text(
                  'Are You sure you want logout',
                  style: GoogleFonts.poppins(color: AppColors.primryColor),
                ),
                btnCancel: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
                btnOk: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  },
                  child: Text(
                    'yes',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
              ).show();
            },
          ),
        ],
      ),
    );
  }
}
