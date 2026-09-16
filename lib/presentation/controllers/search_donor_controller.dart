import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/donor_service.dart';

class SearchDonorController extends GetxController {
  final DonorService _donor = Get.find<DonorService>();

  final isLoading = true.obs;
  final donors = <Map<String, dynamic>>[].obs;
  final searchC = TextEditingController();
  final bloodFilter = Rxn<String>();
  final statusFilter = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    donors.value = await _donor.searchDonors(
      query: searchC.text.trim().isEmpty ? null : searchC.text.trim(),
      bloodGroup: bloodFilter.value,
      status: statusFilter.value,
    );
    isLoading.value = false;
  }

  void clearSearch() {
    searchC.clear();
    load();
  }

  Future<void> updateStatus(String id, String status) async {
    await _donor.updateStatus(id, status);
    Get.snackbar('Updated', 'Status → $status',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100);
    load();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
