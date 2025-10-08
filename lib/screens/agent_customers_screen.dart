import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/screens/client_details_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/agent_customers_list.dart';
import 'package:hero_location/widgets/custom_card.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class AgentCustomersScreen extends StatelessWidget {
  final String agentId;
  final String agentName;

  const AgentCustomersScreen({
    super.key,
    required this.agentId,
    required this.agentName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$agentName Customers'),
        backgroundColor: AppColors.primryColor,
      ),
      body: AgentCustomersList(agentId: agentId),
    );
  }
}
