import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/admin_users_list.dart';
import 'package:hero_location/widgets/agent_customers_list.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';
import 'package:hero_location/widgets/no_connection_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool hasConnection = true;

  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasConnection = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasConnection) {
      return const NoConnectionWidget();
    }

    final currentUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirestoreService.getUser(currentUser.uid).asStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primryColor),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          );
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const EmptyHomeScreen();
        }

        final userData = snapshot.data!.data()!;
        final role = userData['role'] ?? 'agent';

        if (role == 'admin') {
          return const AdminUsersList();
        } else {
          return AgentCustomersList(agentId: currentUser.uid);
        }
      },
    );
  }
}
