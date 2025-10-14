import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/screens/Add_clint_location_screen.dart';
import 'package:hero_location/screens/tabs/home_tab.dart';
import 'package:hero_location/screens/tabs/settings_tab.dart';
import 'package:hero_location/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool showFab = true;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // 👈 GlobalKey للـ ScaffoldMessenger

  // 👈 getter عشان نستخدم _scaffoldMessengerKey بدون initializer error
  List<Widget> get tabs => [
    HomeTab(scaffoldMessengerKey: _scaffoldMessengerKey), // 👈 مرر الـ key
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey, // 👈 صحيح: key على ScaffoldMessenger
      child: Scaffold(
        // 👈 wrap Scaffold جواه
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            selectedIndex == 0
                ? AppLocalizations.of(context)!.home
                : AppLocalizations.of(context)!.settings,
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: AppColors.primryColor,
          centerTitle: true,
        ),
        body: tabs[selectedIndex],
        floatingActionButton: selectedIndex == 0
            ? showFab
                  ? FloatingActionButton(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AddClintLocationScreen.routeName,
                        );
                      },
                      child: Icon(Icons.add),
                    )
                  : null
            : null,
        bottomNavigationBar: BottomNav(
          selectedIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
