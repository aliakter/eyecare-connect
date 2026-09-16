import 'package:get/get.dart';
import '../controllers/admin_home_controller.dart';
import '../controllers/admin_list_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/donation_status_controller.dart';
import '../controllers/donor_card_controller.dart';
import '../controllers/donor_home_controller.dart';
import '../controllers/donor_register_controller.dart';
import '../controllers/hospital_home_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/search_donor_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

class DonorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorHomeController());
  }
}

class DonorRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorRegisterController());
  }
}

class DonorCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorCardController());
  }
}

class DonationStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonationStatusController());
  }
}

class HospitalHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HospitalHomeController());
  }
}

class SearchDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchDonorController());
  }
}

class AdminHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminHomeController());
  }
}

class ManageUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageUsersController());
  }
}

class ManageHospitalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageHospitalsController());
  }
}

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
