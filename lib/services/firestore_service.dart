import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// إضافة مستخدم
  static Future<void> addUser({
    required String uid,
    required String name,
    required String email,
    required String phone,
    String role = 'agent', // agent أو admin
  }) async {
    await _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// جلب بيانات مستخدم
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
    String uid,
  ) async {
    return await _db.collection('users').doc(uid).get();
  }

  /// تحديث بيانات مستخدم
  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  /// إضافة عميل للمندوب الحالي
  static Future<void> addCustomer({
    required String name,
    required String phone,
    required String address,
    required GeoPoint location,
    required String agentId, // الـ uid للمندوب
  }) async {
    await _db.collection('users').doc(agentId).collection('customers').add({
      'name': name,
      'phone': phone,
      'address': address,
      'location': location,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// جلب العملاء لمندوب معين
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCustomersByAgent(
    String agentId,
  ) {
    return _db
        .collection('users')
        .doc(agentId)
        .collection('customers')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// جلب كل المستخدمين (للادمن)
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return _db
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// تحديث بيانات عميل
  static Future<void> updateCustomer({
    required String agentId,
    required String customerId,
    required Map<String, dynamic> data,
  }) async {
    await _db
        .collection('users')
        .doc(agentId)
        .collection('customers')
        .doc(customerId)
        .update(data);
  }

  /// حذف عميل
  static Future<void> deleteCustomer({
    required String agentId,
    required String customerId,
  }) async {
    await _db
        .collection('users')
        .doc(agentId)
        .collection('customers')
        .doc(customerId)
        .delete();
  }
}
