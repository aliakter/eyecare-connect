import 'package:get/get.dart';
import '../../data/donor_service.dart';
import '../routes/app_routes.dart';

class DonorCardController extends GetxController {
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = true.obs;
  final donor = Rxn<Map<String, dynamic>>();

  bool get hasCard =>
      donor.value != null && donor.value!['isRegistered'] == true;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    donor.value = await _donor.getMyDonor();
    isLoading.value = false;
  }

  void goRegister() => Get.toNamed(Routes.donorRegister);
}
