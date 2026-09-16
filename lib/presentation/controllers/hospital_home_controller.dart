import 'package:get/get.dart';
import '../../data/auth_service.dart';
import '../../data/donor_service.dart';
import '../routes/app_routes.dart';

class HospitalHomeController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = true.obs;
  final total = 0.obs;
  final pending = 0.obs;
  final verified = 0.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    final stats = await _donor.getStats();
    total.value = stats['total'] ?? 0;
    pending.value = stats['pending'] ?? 0;
    verified.value = (stats['verified'] ?? 0) + (stats['donated'] ?? 0);
    isLoading.value = false;
  }

  void goSearch() async {
    await Get.toNamed(Routes.searchDonor);
    load();
  }
}
