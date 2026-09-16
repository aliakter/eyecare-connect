import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

/// Firestore donors collection service
class DonorService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthService get _auth => Get.find<AuthService>();

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('donors');

  Future<Map<String, dynamic>?> getMyDonor() async {
    final uid = _auth.uid;
    if (uid.isEmpty) return null;
    final doc = await _col.doc(uid).get();
    if (!doc.exists) return null;
    return {'id': doc.id, ...doc.data()!};
  }

  Future<bool> isRegistered() async {
    final d = await getMyDonor();
    return d != null && d['isRegistered'] == true;
  }

  Future<void> registerDonor({
    required String name,
    required String email,
    required String phone,
    required String dateOfBirth,
    required String bloodGroup,
    required String address,
    required String emergencyContact,
    required String emergencyPhone,
  }) async {
    final uid = _auth.uid;
    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'bloodGroup': bloodGroup,
      'address': address,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'isRegistered': true,
      'status': 'pending',
      'registrationDate':
          DateTime.now().toIso8601String().split('T').first,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await _col.doc(uid).set(data, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> searchDonors({
    String? query,
    String? bloodGroup,
    String? status,
  }) async {
    Query<Map<String, dynamic>> q =
        _col.where('isRegistered', isEqualTo: true);

    if (status != null && status.isNotEmpty) {
      q = q.where('status', isEqualTo: status);
    }
    if (bloodGroup != null && bloodGroup.isNotEmpty) {
      q = q.where('bloodGroup', isEqualTo: bloodGroup);
    }

    final snap = await q.limit(100).get();
    var list = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();

    if (query != null && query.trim().isNotEmpty) {
      final lower = query.toLowerCase();
      list = list
          .where((d) =>
              (d['name'] ?? '').toString().toLowerCase().contains(lower) ||
              (d['phone'] ?? '').toString().contains(query) ||
              (d['email'] ?? '').toString().toLowerCase().contains(lower))
          .toList();
    }
    return list;
  }

  Future<void> updateStatus(String donorId, String status) async {
    await _col.doc(donorId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, int>> getStats() async {
    final snap =
        await _col.where('isRegistered', isEqualTo: true).get();
    int pending = 0, verified = 0, donated = 0;
    for (final d in snap.docs) {
      final s = d.data()['status'] ?? 'pending';
      if (s == 'pending') pending++;
      if (s == 'verified') verified++;
      if (s == 'donated') donated++;
    }
    return {
      'total': snap.docs.length,
      'pending': pending,
      'verified': verified,
      'donated': donated,
    };
  }
}
