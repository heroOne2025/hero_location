import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_assets.dart';
import 'package:hero_location/screens/change_language_screen.dart';
import 'package:hero_location/screens/change_password_screen.dart';
import 'package:hero_location/screens/edit_profile_screen.dart';
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
            text: 'Change Language',
            onTap: () {
              Navigator.pushNamed(context, ChangeLanguageScreen.routeName);
            },
          ),
          ClickedRow(avatar: AppAssets.logout, text: 'Logout'),
        ],
      ),
    );
  }
}
