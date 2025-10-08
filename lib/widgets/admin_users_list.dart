import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/screens/agent_customers_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_card.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class AdminUsersList extends StatelessWidget {
  const AdminUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirestoreService.getAllUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final agents = snapshot.data!.docs;

        if (agents.isEmpty) return const EmptyHomeScreen();

        return ListView.builder(
          itemCount: agents.length,
          itemBuilder: (context, index) {
            final agentDoc = agents[index]; // ✅ المستند الكامل
            final agent = agentDoc.data(); // ✅ بيانات المندوب

            return CustomCard(
              name: agent['name'],
              phone: agent['phone'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AgentCustomersScreen(
                      agentId: agentDoc.id, // ✅ استخدم ID المندوب
                      agentName: agent['name'], // ✅ اسم المندوب
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
