import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/widgets/agent_customers_list.dart';

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
        title: Text('${agentName + AppLocalizations.of(context)!.customers}'),
        backgroundColor: AppColors.primryColor,
      ),
      body: AgentCustomersList(agentId: agentId),
    );
  }
}
