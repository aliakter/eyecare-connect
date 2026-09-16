import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/donor_card_controller.dart';

class DonorCardPage extends GetView<DonorCardController> {
  const DonorCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Donor Card'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!controller.hasCard) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.badge_outlined, size: 80, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                const Text('No Donor Card Yet',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.goRegister,
                  child: const Text('Register Now'),
                ),
              ],
            ),
          );
        }
        final d = controller.donor.value!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryLight,
                  Color(0xFF1A9B9F),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('EyeCare Connect',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        (d['status'] ?? 'pending').toString().toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text('EYE DONOR',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        letterSpacing: 1.5)),
                Text(d['name'] ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text('Blood: ${d['bloodGroup'] ?? '-'}',
                    style: const TextStyle(color: Colors.white)),
                Text('Phone: ${d['phone'] ?? '-'}',
                    style: const TextStyle(color: Colors.white)),
                Text('Registered: ${d['registrationDate'] ?? '-'}',
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
