import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/screens/tabs/home_tab.dart';
import 'package:hero_location/screens/tabs/settings_tab.dart';
import 'package:hero_location/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [const HomeTab(), const SettingsTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedIndex == 0 ? 'Home' : 'Settings'),
        backgroundColor: AppColors.primryColor,
        centerTitle: true,
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
