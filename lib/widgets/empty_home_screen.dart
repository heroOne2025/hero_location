import 'package:flutter/material.dart';
import 'package:hero_location/screens/Add_clint_location_screen.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/empty_ghost.gif',
            height: 120,
            width: double.infinity,
          ),

          Text(
            'No clints yet',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomElevatedButton(
              textOnButton: 'Add clint',
              onPressed: () {
                Navigator.pushNamed(context, AddClintLocationScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
