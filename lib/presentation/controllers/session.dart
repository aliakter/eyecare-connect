import 'package:get/get.dart';
import '../routes/app_routes.dart';

/// Simple in-memory session for demo (no Firebase)
class Session extends GetxController {
  final name = 'Demo User'.obs;
  final email = 'demo@eyecare.com'.obs;
  final phone = '01700000000'.obs;
  final role = 'donor'.obs; // donor | hospital | admin
  final isDonorRegistered = false.obs;
  final donationStatus = 'pending'.obs; // pending | verified | donated

  String get roleLabel {
    switch (role.value) {
      case 'hospital':
        return 'Hospital / Eye Bank';
      case 'admin':
        return 'Admin';
      default:
        return 'Eye Donor';
    }
  }

  String homeRoute() {
    switch (role.value) {
      case 'hospital':
        return Routes.hospitalHome;
      case 'admin':
        return Routes.adminHome;
      default:
        return Routes.donorHome;
    }
  }

  void loginAs(String r) {
    role.value = r;
    if (r == 'donor') {
      name.value = 'Karim Rahman';
      email.value = 'karim@email.com';
    } else if (r == 'hospital') {
      name.value = 'Dr. Sara Ahmed';
      email.value = 'sara@hospital.com';
    } else {
      name.value = 'Admin User';
      email.value = 'admin@eyecare.com';
    }
  }

  void logout() {
    isDonorRegistered.value = false;
    donationStatus.value = 'pending';
    Get.offAllNamed(Routes.login);
  }
}
