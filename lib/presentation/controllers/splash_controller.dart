import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../data/auth_service.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    if (_auth.isLoggedIn) {
      await _auth.loadUserData();
      final role = _auth.role;
      if (role == AppConstants.roleHospital) {
        Get.offAllNamed(Routes.hospitalHome);
      } else if (role == AppConstants.roleAdmin) {
        Get.offAllNamed(Routes.adminHome);
      } else {
        Get.offAllNamed(Routes.donorHome);
      }
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
