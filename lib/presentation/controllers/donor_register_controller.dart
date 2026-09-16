import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/auth_service.dart';
import '../../data/donor_service.dart';
import '../routes/app_routes.dart';

class DonorRegisterController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = false.obs;
  final bloodGroup = 'O+'.obs;

  late final nameC = TextEditingController(text: auth.name);
  late final emailC = TextEditingController(text: auth.email);
  late final phoneC = TextEditingController(text: auth.phone);
  final dobC = TextEditingController();
  final addressC = TextEditingController();
  final emergencyNameC = TextEditingController();
  final emergencyPhoneC = TextEditingController();

  Future<void> pickDob(BuildContext context) async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (d != null) dobC.text = '${d.day}/${d.month}/${d.year}';
  }

  Future<void> submit() async {
    if (nameC.text.trim().isEmpty ||
        phoneC.text.trim().isEmpty ||
        addressC.text.trim().isEmpty ||
        emergencyNameC.text.trim().isEmpty ||
        emergencyPhoneC.text.trim().isEmpty) {
      Get.snackbar('Error', 'Fill all required fields',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isLoading.value = true;
    try {
      await _donor.registerDonor(
        name: nameC.text.trim(),
        email: emailC.text.trim(),
        phone: phoneC.text.trim(),
        dateOfBirth: dobC.text.trim(),
        bloodGroup: bloodGroup.value,
        address: addressC.text.trim(),
        emergencyContact: emergencyNameC.text.trim(),
        emergencyPhone: emergencyPhoneC.text.trim(),
      );
      Get.snackbar('Success', 'Donor registration saved!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100);
      Get.offNamed(Routes.donorCard);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    dobC.dispose();
    addressC.dispose();
    emergencyNameC.dispose();
    emergencyPhoneC.dispose();
    super.onClose();
  }
}
