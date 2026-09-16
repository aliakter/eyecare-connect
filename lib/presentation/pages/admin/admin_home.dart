import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/admin_home_controller.dart';
import '../../widgets/app_drawer.dart';

class AdminHomePage extends GetView<AdminHomeController> {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Hello, ${controller.auth.name}',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _stat('Users', '${controller.users.value}',
                        Icons.people, Colors.blue)),
                const SizedBox(width: 10),
                Expanded(
                    child: _stat('Hospitals', '${controller.hospitals.value}',
                        Icons.local_hospital, Colors.teal)),
                const SizedBox(width: 10),
                Expanded(
                    child: _stat('Donors', '${controller.donors.value}',
                        Icons.volunteer_activism, Colors.orange)),
              ],
            ),
            const SizedBox(height: 24),
            _tile(Icons.people_outline, 'Manage Users', controller.goUsers),
            _tile(Icons.local_hospital_outlined, 'Manage Hospitals',
                controller.goHospitals),
            _tile(Icons.bar_chart, 'Generate Reports', controller.goReports),
          ],
        );
      }),
    );
  }

  Widget _stat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
