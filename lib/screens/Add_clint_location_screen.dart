import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/widgets/add_clint_location_form.dart';

class AddClintLocationScreen extends StatelessWidget {
  static String routeName = '/add_clint_location';
  const AddClintLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addClientLocation,
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: AppColors.primryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddClintLocationForm(),
        ),
      ),
    );
  }
}
