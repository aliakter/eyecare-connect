import 'package:get/get.dart';
import '../../data/auth_service.dart';
import '../../data/donor_service.dart';

class ManageUsersController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();
  final isLoading = true.obs;
  final users = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    users.value = await _auth.getAllUsers();
    isLoading.value = false;
  }
}

class ManageHospitalsController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();
  final isLoading = true.obs;
  final hospitals = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    hospitals.value = await _auth.getHospitals();
    isLoading.value = false;
  }
}

class ReportsController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = true.obs;
  final stats = <String, int>{}.obs;
  final users = 0.obs;
  final hospitals = 0.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    stats.value = await _donor.getStats();
    users.value = (await _auth.getAllUsers()).length;
    hospitals.value = (await _auth.getHospitals()).length;
    isLoading.value = false;
  }
}
