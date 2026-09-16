import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/hospital_home_controller.dart';
import '../../widgets/app_drawer.dart';

class HospitalHomePage extends GetView<HospitalHomeController> {
  const HospitalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Hospital Dashboard'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: controller.load,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                  'Welcome, ${controller.auth.hospitalName ?? controller.auth.name}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _stat(
                          'Total', '${controller.total.value}', Icons.people)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _stat('Pending', '${controller.pending.value}',
                          Icons.pending)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _stat('Verified', '${controller.verified.value}',
                          Icons.verified)),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.search, color: AppTheme.primaryColor),
                  title: const Text('Search & Verify Donor',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Find donors and update status'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: controller.goSearch,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _stat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 22),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}
