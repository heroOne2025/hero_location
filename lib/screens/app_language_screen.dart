import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';

class AppLanguage extends StatefulWidget {
  static const routeName = '/app-language';
  const AppLanguage({super.key});

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  String language = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Language')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose your language ',
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
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    activeColor: AppColors.primryColor,
                    value: 'English',
                    title: Text('English', style: GoogleFonts.poppins()),
                    selected: language == 'English',
                  ),
                  RadioListTile<String>(
                    activeColor: AppColors.primryColor,
                    value: 'Arabic',
                    title: Text('Arabic', style: GoogleFonts.poppins()),
                    selected: language == 'Arabic',
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
