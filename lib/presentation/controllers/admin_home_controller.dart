import 'package:get/get.dart';
import '../../data/auth_service.dart';
import '../../data/donor_service.dart';
import '../routes/app_routes.dart';

class AdminHomeController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = true.obs;
  final users = 0.obs;
  final hospitals = 0.obs;
  final donors = 0.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    final all = await auth.getAllUsers();
    final hos = await auth.getHospitals();
    final stats = await _donor.getStats();
    users.value = all.length;
    hospitals.value = hos.length;
    donors.value = stats['total'] ?? 0;
    isLoading.value = false;
  }

  void goUsers() => Get.toNamed(Routes.manageUsers);
  void goHospitals() => Get.toNamed(Routes.manageHospitals);
  void goReports() => Get.toNamed(Routes.reports);
}
