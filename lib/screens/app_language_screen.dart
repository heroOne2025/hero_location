import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    value: 'English',
                    title: const Text('English'),
                    selected: language == 'English',
                  ),
                  RadioListTile<String>(
                    value: 'Arabic',
                    title: const Text('Arabic'),
                    selected: language == 'Arabic',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
