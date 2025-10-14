import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_assets.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/l10n/app_localizations.dart';
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
            text: AppLocalizations.of(context)!.editProfile,
            onTap: () {
              Navigator.pushNamed(context, EditProfileScreen.routeName);
            },
          ),
          ClickedRow(
            avatar: AppAssets.changePassword,
            text: AppLocalizations.of(context)!.changePassword,
            onTap: () {
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),
          ClickedRow(
            avatar: AppAssets.changeLanguage,
            text: AppLocalizations.of(context)!.appLanguage,
            onTap: () {
              Navigator.pushNamed(context, AppLanguage.routeName);
            },
          ),
          ClickedRow(
            avatar: AppAssets.logout,
            text: AppLocalizations.of(context)!.logout,
            onTap: () async {
              AwesomeDialog(
                context: context,
                autoDismiss: true,
                dialogType: DialogType.warning,
                body: Text(
                  AppLocalizations.of(context)!.areYouSureLogout,
                  style: GoogleFonts.poppins(color: AppColors.primryColor),
                ),
                btnCancel: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
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
                    AppLocalizations.of(context)!.yes,
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
