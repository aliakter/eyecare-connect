import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../data/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  final isLoading = false.obs;
  final showPassword = false.obs;
  final selectedRole = AppConstants.roleDonor.obs;

  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();

  final regName = TextEditingController();
  final regEmail = TextEditingController();
  final regPhone = TextEditingController();
  final regPassword = TextEditingController();
  final regHospital = TextEditingController();
  final regAddress = TextEditingController();

  void togglePassword() => showPassword.value = !showPassword.value;

  String homeForRole(String role) {
    switch (role) {
      case AppConstants.roleHospital:
        return Routes.hospitalHome;
      case AppConstants.roleAdmin:
        return Routes.adminHome;
      default:
        return Routes.donorHome;
    }
  }

  Future<void> login() async {
    if (loginEmail.text.trim().isEmpty || loginPassword.text.isEmpty) {
      _error('Enter email & password');
      return;
    }
    isLoading.value = true;
    try {
      await _auth.login(loginEmail.text, loginPassword.text);
      Get.offAllNamed(homeForRole(_auth.role));
    } catch (e) {
      _error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final role = selectedRole.value;
    if (regName.text.trim().isEmpty ||
        regEmail.text.trim().isEmpty ||
        regPhone.text.trim().isEmpty ||
        regPassword.text.length < 6) {
      _error('Fill all fields. Password min 6 chars.');
      return;
    }
    if (role == AppConstants.roleHospital && regHospital.text.trim().isEmpty) {
      _error('Enter hospital name');
      return;
    }
    isLoading.value = true;
    try {
      await _auth.register(
        name: regName.text,
        email: regEmail.text,
        phone: regPhone.text,
        password: regPassword.text,
        role: role,
        hospitalName:
            role == AppConstants.roleHospital ? regHospital.text.trim() : null,
        address: regAddress.text.trim().isEmpty ? null : regAddress.text.trim(),
      );
      Get.offAllNamed(homeForRole(role));
    } catch (e) {
      _error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.logout();
    Get.offAllNamed(Routes.login);
  }

  void _error(String msg) {
    Get.snackbar('Error', msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100);
  }

  @override
  void onClose() {
    loginEmail.dispose();
    loginPassword.dispose();
    regName.dispose();
    regEmail.dispose();
    regPhone.dispose();
    regPassword.dispose();
    regHospital.dispose();
    regAddress.dispose();
    super.onClose();
  }
}
