import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/provider/chanage_language_provider.dart';
import 'package:provider/provider.dart';

class AppLanguage extends StatefulWidget {
  static const routeName = '/app-language';
  const AppLanguage({super.key});

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  String language = 'en';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChanageLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appLanguage)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.chooseYourLanguage,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            RadioGroup<String>(
              groupValue: language,
              onChanged: (val) {
                setState(() {
                  language = val!;
                });
                provider.changeLanguge(val!);
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    activeColor: AppColors.primryColor,
                    value: 'en',
                    title: Text(
                      AppLocalizations.of(context)!.english,
                      style: GoogleFonts.poppins(),
                    ),
                    selected: language == 'en',
                  ),
                  RadioListTile<String>(
                    activeColor: AppColors.primryColor,
                    value: 'ar',
                    title: Text(
                      AppLocalizations.of(context)!.arabic,
                      style: GoogleFonts.poppins(),
                    ),
                    selected: language == 'ar',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
