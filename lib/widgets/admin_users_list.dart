import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/screens/agent_customers_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_card.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class AdminUsersList extends StatefulWidget {
  const AdminUsersList({super.key});

  @override
  State<AdminUsersList> createState() => _AdminUsersListState();
}

class _AdminUsersListState extends State<AdminUsersList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _deleteAgent(
    BuildContext context,
    String agentId,
    Map<String, dynamic> agentData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(agentId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Agent deleted successfully'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(agentId)
                    .set(agentData);
                // 👈 إضافة: تحديث الشاشة بعد الـ restore
                setState(() {}); // يجبر الـ StreamBuilder يقرأ تاني
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Agent restored')));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error restoring agent: $e')),
                );
              }
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting agent: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() {
              _searchQuery = value.toLowerCase();
            }),
            decoration: InputDecoration(
              hintText: 'Search agents by name or phone...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
            ),
            style: GoogleFonts.poppins(),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirestoreService.getAllUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final allAgents = snapshot.data!.docs;
              final filteredAgents = allAgents.where((agentDoc) {
                final agent = agentDoc.data();
                final name = agent['name']?.toString().toLowerCase() ?? '';
                final phone = agent['phone']?.toString().toLowerCase() ?? '';
                return name.contains(_searchQuery) ||
                    phone.contains(_searchQuery);
              }).toList();

              if (filteredAgents.isEmpty) {
                return const EmptyHomeScreen();
              }

              return ListView.builder(
                itemCount: filteredAgents.length,
                itemBuilder: (context, index) {
                  final agentDoc = filteredAgents[index];
                  final agent = agentDoc.data();

                  return Dismissible(
                    key: Key(agentDoc.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        _deleteAgent(context, agentDoc.id, agent),
                    background: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8.0),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      name: agent['name'],
                      phone: agent['phone'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AgentCustomersScreen(
                              agentId: agentDoc.id,
                              agentName: agent['name'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
