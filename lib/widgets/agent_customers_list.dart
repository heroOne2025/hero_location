import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/screens/client_details_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_card.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class AgentCustomersList extends StatelessWidget {
  final String agentId;
  const AgentCustomersList({super.key, required this.agentId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirestoreService.getCustomersByAgent(agentId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final customers = snapshot.data!.docs;
        if (customers.isEmpty) return const EmptyHomeScreen();

        return ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customerDoc = customers[index];
            final customer = customerDoc.data();
            final customerId = customerDoc.id;

            return CustomCard(
              name: customer['name'],
              phone: customer['phone'],
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  ClientDetailsScreen.routeName,
                  arguments: customerId,
                );

                if (result == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Client updated successfully'),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
