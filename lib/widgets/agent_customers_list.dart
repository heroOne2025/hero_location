import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/screens/client_details_screen.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:hero_location/widgets/custom_card.dart';
import 'package:hero_location/widgets/empty_home_screen.dart';

class AgentCustomersList extends StatefulWidget {
  final String agentId;
  const AgentCustomersList({super.key, required this.agentId});

  @override
  State<AgentCustomersList> createState() => _AgentCustomersListState();
}

class _AgentCustomersListState extends State<AgentCustomersList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<String?> _getCurrentRole() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();
      return doc.exists ? doc.data()!['role'] ?? 'agent' : 'agent';
    } catch (e) {
      return 'agent';
    }
  }

  Future<void> _deleteCustomer(
    BuildContext context,
    String agentId,
    String customerId,
    Map<String, dynamic> customerData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(agentId)
          .collection('customers')
          .doc(customerId)
          .delete();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Client deleted successfully'),
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
                    .collection('customers')
                    .doc(customerId)
                    .set(customerData);
                if (mounted) setState(() {});
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Client restored')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error restoring client: $e')),
                  );
                }
              }
            },
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error deleting client: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getCurrentRole(),
      builder: (context, roleSnapshot) {
        if (!roleSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final isAdmin = roleSnapshot.data == 'admin';

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
                  hintText: 'Search clients by name or phone...',
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
                stream: FirestoreService.getCustomersByAgent(widget.agentId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final allCustomers = snapshot.data!.docs;
                  final filteredCustomers = allCustomers.where((customerDoc) {
                    final customer = customerDoc.data();
                    final name =
                        customer['name']?.toString().toLowerCase() ?? '';
                    final phone =
                        customer['phone']?.toString().toLowerCase() ?? '';
                    return name.contains(_searchQuery) ||
                        phone.contains(_searchQuery);
                  }).toList();

                  if (filteredCustomers.isEmpty) return const EmptyHomeScreen();

                  return ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customerDoc = filteredCustomers[index];
                      final customer = customerDoc.data();
                      final customerId = customerDoc.id;

                      final card = CustomCard(
                        name: customer['name'],
                        phone: customer['phone'],
                        onTap: () async {
                          // 👈 إصلاح: مرر agentId دائمًا (للـ admin أو agent)
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ClientDetailsScreen(
                                clientId: customerId,
                                agentId: widget.agentId, // 👈 مرر agentId هنا
                              ),
                            ),
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

                      if (!isAdmin) {
                        return card;
                      }

                      return Dismissible(
                        key: Key(customerId),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) => _deleteCustomer(
                          context,
                          widget.agentId,
                          customerId,
                          customer,
                        ),
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
      },
    );
  }
}
