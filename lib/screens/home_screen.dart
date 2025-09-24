import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My clints'),
        backgroundColor: AppColors.primryColor,
        centerTitle: true,
      ),
      body: EmptyHomeScreen(),
    );
  }
}
