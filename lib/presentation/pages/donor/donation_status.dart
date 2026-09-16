import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/donation_status_controller.dart';

class DonationStatusPage extends GetView<DonationStatusController> {
  const DonationStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Status'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!controller.isRegistered) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.goRegister,
              child: const Text('Register First'),
            ),
          );
        }
        final status = controller.status;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.dividerColor),
              ),
              child: Column(
                children: [
                  Text(status.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(
                      'Registered: ${controller.donor.value?['registrationDate'] ?? '-'}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _step('Registration Submitted', true),
            _step('Hospital Verification',
                status == 'verified' || status == 'donated'),
            _step('Donation Completed', status == 'donated'),
          ],
        );
      }),
    );
  }

  Widget _step(String title, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done ? AppTheme.successColor : Colors.grey),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
    );
  }
}
