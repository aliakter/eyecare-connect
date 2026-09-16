import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// Central Firebase Auth + User profile service
class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final Rxn<User> firebaseUser = Rxn<User>();
  final Rxn<Map<String, dynamic>> userData = Rxn<Map<String, dynamic>>();

  String get uid => firebaseUser.value?.uid ?? '';
  String get role => userData.value?['role'] ?? 'donor';
  String get name => userData.value?['name'] ?? '';
  String get email => userData.value?['email'] ?? '';
  String get phone => userData.value?['phone'] ?? '';
  String? get hospitalName => userData.value?['hospitalName'];
  bool get isLoggedIn => firebaseUser.value != null;

  Future<AuthService> init() async {
    firebaseUser.value = _auth.currentUser;
    if (firebaseUser.value != null) {
      await loadUserData();
    }
    _auth.authStateChanges().listen((u) async {
      firebaseUser.value = u;
      if (u != null) {
        await loadUserData();
      } else {
        userData.value = null;
      }
    });
    return this;
  }

  Future<void> loadUserData() async {
    if (uid.isEmpty) return;
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      userData.value = {'id': doc.id, ...doc.data()!};
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
    String? hospitalName,
    String? address,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await cred.user?.updateDisplayName(name);
    final data = {
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'role': role,
      'hospitalName': hospitalName,
      'address': address,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await _db.collection('users').doc(cred.user!.uid).set(data);
    firebaseUser.value = cred.user;
    userData.value = {'id': cred.user!.uid, ...data};
  }

  Future<void> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    firebaseUser.value = cred.user;
    await loadUserData();
  }

  Future<void> logout() async {
    await _auth.signOut();
    firebaseUser.value = null;
    userData.value = null;
  }

  /// Admin helpers
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final snap = await _db.collection('users').orderBy('name').get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> getHospitals() async {
    final snap = await _db
        .collection('users')
        .where('role', isEqualTo: 'hospital')
        .get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }
}
