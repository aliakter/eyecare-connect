import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../controllers/donor_register_controller.dart';

class DonorRegisterPage extends GetView<DonorRegisterController> {
  const DonorRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eye Donation Registration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
                controller: controller.nameC,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 12),
            TextField(
                controller: controller.phoneC,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: 'Phone *',
                    prefixIcon: Icon(Icons.phone_outlined))),
            const SizedBox(height: 12),
            TextField(
              controller: controller.dobC,
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today_outlined)),
              onTap: () => controller.pickDob(context),
            ),
            const SizedBox(height: 12),
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.bloodGroup.value,
                  decoration: const InputDecoration(
                      labelText: 'Blood Group *',
                      prefixIcon: Icon(Icons.bloodtype_outlined)),
                  items: AppConstants.bloodGroups
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) =>
                      controller.bloodGroup.value = v ?? 'O+',
                )),
            const SizedBox(height: 12),
            TextField(
                controller: controller.addressC,
                textInputAction: TextInputAction.next,
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: 'Address *',
                    prefixIcon: Icon(Icons.location_on_outlined))),
            const SizedBox(height: 20),
            const Text('Emergency Contact',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
                controller: controller.emergencyNameC,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Contact Name *',
                    prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 12),
            TextField(
                controller: controller.emergencyPhoneC,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: 'Contact Phone *',
                    prefixIcon: Icon(Icons.phone_outlined))),
            const SizedBox(height: 28),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.submit,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('Submit Registration'),
                )),
          ],
        ),
      ),
    );
  }
}
