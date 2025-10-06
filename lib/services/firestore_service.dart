import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser({
    required String uid,
    required String name,
    required String email,
    required String phone,
    String role = 'agent',
  }) async {
    await _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
    String uid,
  ) async {
    return await _db.collection('users').doc(uid).get();
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  static Future<void> addCustomer({
    required String name,
    required String phone,
    required String address,
    required GeoPoint location,
    required String agentId,
    required String createdBy, // uid اللي أضاف العميل (مندوب أو أدمن)
  }) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _db.collection('users').doc(uid).collection('customers').add({
      'name': name,
      'phone': phone,
      'location': location,
      'agentId': agentId,
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// جلب العملاء حسب المندوب
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCustomersByAgent(
    String agentId,
  ) {
    return _db
        .collection('customers')
        .where('agentId', isEqualTo: agentId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// جلب كل العملاء (للإدارة)
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers() {
    return _db
        .collection('customers')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// تحديث بيانات العميل
  static Future<void> updateCustomer(
    String customerId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection('customers').doc(customerId).update(data);
  }

  /// حذف العميل
  static Future<void> deleteCustomer(String customerId) async {
    await _db.collection('customers').doc(customerId).delete();
  }
}
