import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/search_donor_controller.dart';

class SearchDonorPage extends GetView<SearchDonorController> {
  const SearchDonorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Verify Donor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: controller.searchC,
                  decoration: InputDecoration(
                    hintText: 'Search name, phone, email',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: controller.clearSearch,
                    ),
                  ),
                  onSubmitted: (_) => controller.load(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<String>(
                            value: controller.bloodFilter.value,
                            decoration: const InputDecoration(
                                labelText: 'Blood',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8)),
                            items: [
                              const DropdownMenuItem(
                                  value: null, child: Text('All')),
                              ...AppConstants.bloodGroups.map((g) =>
                                  DropdownMenuItem(value: g, child: Text(g))),
                            ],
                            onChanged: (v) {
                              controller.bloodFilter.value = v;
                              controller.load();
                            },
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<String>(
                            value: controller.statusFilter.value,
                            decoration: const InputDecoration(
                                labelText: 'Status',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8)),
                            items: const [
                              DropdownMenuItem(
                                  value: null, child: Text('All')),
                              DropdownMenuItem(
                                  value: 'pending', child: Text('Pending')),
                              DropdownMenuItem(
                                  value: 'verified',
                                  child: Text('Verified')),
                              DropdownMenuItem(
                                  value: 'donated', child: Text('Donated')),
                              DropdownMenuItem(
                                  value: 'rejected',
                                  child: Text('Rejected')),
                            ],
                            onChanged: (v) {
                              controller.statusFilter.value = v;
                              controller.load();
                            },
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.donors.isEmpty) {
                return const Center(child: Text('No donors found'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.donors.length,
                itemBuilder: (context, i) {
                  final d = controller.donors[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            AppTheme.primaryColor.withOpacity(0.15),
                        child: Text(
                          (d['name'] ?? '?')[0].toString().toUpperCase(),
                          style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(d['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          '${d['bloodGroup'] ?? '-'} • ${d['phone'] ?? '-'}\nStatus: ${(d['status'] ?? 'pending').toString().toUpperCase()}'),
                      isThreeLine: true,
                      trailing: PopupMenuButton<String>(
                        onSelected: (s) =>
                            controller.updateStatus(d['id'], s),
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                              value: 'verified', child: Text('Mark Verified')),
                          PopupMenuItem(
                              value: 'donated', child: Text('Mark Donated')),
                          PopupMenuItem(
                              value: 'rejected', child: Text('Reject')),
                          PopupMenuItem(
                              value: 'pending', child: Text('Set Pending')),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
