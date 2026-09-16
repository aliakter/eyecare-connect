import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = controller.auth;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final name = auth.name.isEmpty ? 'User' : auth.name;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
                child: Text(name[0].toUpperCase(),
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor)),
              ),
            ),
            const SizedBox(height: 16),
            Center(
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600))),
            Center(
              child: Text(AppConstants.roleLabel(auth.role),
                  style: const TextStyle(color: AppTheme.primaryColor)),
            ),
            const SizedBox(height: 28),
            _info(Icons.email_outlined, 'Email', auth.email),
            _info(Icons.phone_outlined, 'Phone', auth.phone),
            if (auth.hospitalName != null)
              _info(Icons.business, 'Hospital', auth.hospitalName!),
          ],
        );
      }),
    );
  }

  Widget _info(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
