import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/admin_list_controller.dart';

class ManageHospitalsPage extends GetView<ManageHospitalsController> {
  const ManageHospitalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Hospitals'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.hospitals.isEmpty) {
          return const Center(child: Text('No hospitals registered'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.hospitals.length,
          itemBuilder: (context, i) {
            final h = controller.hospitals[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.local_hospital,
                    color: AppTheme.primaryColor),
                title: Text(h['hospitalName'] ?? h['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                    '${h['email'] ?? ''}\n${h['phone'] ?? ''} • ${h['address'] ?? ''}'),
                isThreeLine: true,
              ),
            );
          },
        );
      }),
    );
  }
}
