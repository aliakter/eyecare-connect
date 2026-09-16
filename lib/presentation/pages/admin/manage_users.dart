import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/admin_list_controller.dart';

class ManageUsersPage extends GetView<ManageUsersController> {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.users.isEmpty) {
          return const Center(child: Text('No users yet'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.users.length,
          itemBuilder: (context, i) {
            final u = controller.users[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
                  child: Text(
                    (u['name'] ?? '?')[0].toString().toUpperCase(),
                    style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(u['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                    '${u['email'] ?? ''}\n${AppConstants.roleLabel(u['role'] ?? 'donor')} • ${u['phone'] ?? ''}'),
                isThreeLine: true,
              ),
            );
          },
        );
      }),
    );
  }
}
