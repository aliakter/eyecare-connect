import 'package:get/get.dart';
import '../../data/auth_service.dart';
import '../../data/donor_service.dart';
import '../routes/app_routes.dart';

class DonorHomeController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = true.obs;
  final isRegistered = false.obs;
  final status = 'pending'.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    final data = await _donor.getMyDonor();
    isRegistered.value = data != null && data['isRegistered'] == true;
    status.value = data?['status']?.toString() ?? 'pending';
    isLoading.value = false;
  }

  void goRegister() async {
    await Get.toNamed(Routes.donorRegister);
    load();
  }

  void goCard() => Get.toNamed(Routes.donorCard);
  void goStatus() => Get.toNamed(Routes.donationStatus);
  void goProfile() => Get.toNamed(Routes.profile);
}
