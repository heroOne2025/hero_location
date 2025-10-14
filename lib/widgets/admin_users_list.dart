import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/screens/agent_customers_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_card.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class AdminUsersList extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState>?
  scaffoldMessengerKey; // 👈 حديث: ScaffoldMessengerState

  const AdminUsersList({super.key, this.scaffoldMessengerKey});

  @override
  State<AdminUsersList> createState() => _AdminUsersListState();
}

class _AdminUsersListState extends State<AdminUsersList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late final ScaffoldMessengerState
  _scaffoldMessenger; // 👈 حديث: ScaffoldMessengerState reference محفوظ

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 👈 استخدم الـ GlobalKey لو موجود، وإلا الـ local
    _scaffoldMessenger =
        widget.scaffoldMessengerKey?.currentState ??
        ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 👈 إزالة context param، واستخدام _scaffoldMessenger بس
  Future<void> _deleteAgent(
    String agentId,
    Map<String, dynamic> agentData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(agentId)
          .delete();

      if (!mounted) return;

      _scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Agent deleted successfully'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () async {
              if (!mounted) return;

              try {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(agentId)
                    .set(agentData);
                if (mounted)
                  setState(() {}); // 👈 يجبر الـ StreamBuilder يقرأ تاني
                if (mounted) {
                  _scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Agent restored')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  _scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text('Error restoring agent: $e')),
                  );
                }
              }
            },
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        _scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error deleting agent: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth
        .instance
        .currentUser!
        .uid; // 👈 الحصول على ID الـ admin الحالي

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
              hintText: AppLocalizations.of(context)!.searchAgents,
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

              // 👈 البحث عن الـ admin الحالي بـ try-catch عشان الـ type error
              QueryDocumentSnapshot<Map<String, dynamic>>? adminDoc;
              try {
                adminDoc = filteredAgents.firstWhere(
                  (doc) => doc.id == currentUserId,
                );
              } catch (e) {
                adminDoc = null;
              }

              // 👈 الترتيب: الـ admin أولًا، باقي الـ agents بعديه
              final sortedAgents =
                  <QueryDocumentSnapshot<Map<String, dynamic>>>[];
              if (adminDoc != null) {
                sortedAgents.add(adminDoc);
                sortedAgents.addAll(
                  filteredAgents.where((doc) => doc.id != currentUserId),
                );
              } else {
                sortedAgents.addAll(filteredAgents);
              }

              return ListView.builder(
                itemCount: sortedAgents.length,
                itemBuilder: (context, index) {
                  final agentDoc = sortedAgents[index];
                  final agent = agentDoc.data();
                  final isCurrentAdmin =
                      agentDoc.id ==
                      currentUserId; // 👈 تحقق لو ده الـ admin الحالي

                  final card = CustomCard(
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
                  );

                  if (isCurrentAdmin) {
                    // 👈 لو الـ admin الحالي، مش Dismissible (مش قابل للـ delete)
                    return card;
                  }

                  // 👈 باقي الـ agents قابلين للـ delete
                  return Dismissible(
                    key: ValueKey(agentDoc.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        _deleteAgent(agentDoc.id, agent),
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
                    child: card,
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
