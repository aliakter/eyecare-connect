import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../data/auth_service.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();

    return Drawer(
      child: Column(
        children: [
          Obx(() {
            final name = auth.name.isEmpty ? 'User' : auth.name;
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryLight],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white,
                    child: Text(name[0].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor)),
                  ),
                  const SizedBox(height: 12),
                  Text(name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  Text(auth.email,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85), fontSize: 13)),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(AppConstants.roleLabel(auth.role),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              final role = auth.role;
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  if (role == AppConstants.roleDonor) ...[
                    _item(Icons.dashboard_outlined, 'Dashboard',
                        () => Get.offAllNamed(Routes.donorHome)),
                    _item(Icons.volunteer_activism, 'Register as Donor',
                        () => Get.toNamed(Routes.donorRegister)),
                    _item(Icons.badge_outlined, 'Digital Donor Card',
                        () => Get.toNamed(Routes.donorCard)),
                    _item(Icons.timeline, 'Donation Status',
                        () => Get.toNamed(Routes.donationStatus)),
                    _item(Icons.person_outline, 'Profile',
                        () => Get.toNamed(Routes.profile)),
                  ],
                  if (role == AppConstants.roleHospital) ...[
                    _item(Icons.dashboard_outlined, 'Dashboard',
                        () => Get.offAllNamed(Routes.hospitalHome)),
                    _item(Icons.search, 'Search Donor',
                        () => Get.toNamed(Routes.searchDonor)),
                  ],
                  if (role == AppConstants.roleAdmin) ...[
                    _item(Icons.dashboard_outlined, 'Dashboard',
                        () => Get.offAllNamed(Routes.adminHome)),
                    _item(Icons.people_outline, 'Manage Users',
                        () => Get.toNamed(Routes.manageUsers)),
                    _item(Icons.local_hospital_outlined, 'Manage Hospitals',
                        () => Get.toNamed(Routes.manageHospitals)),
                    _item(Icons.bar_chart, 'Reports',
                        () => Get.toNamed(Routes.reports)),
                  ],
                  const Divider(),
                  _item(Icons.logout, 'Logout', () {
                    if (Get.isRegistered<AuthController>()) {
                      Get.find<AuthController>().logout();
                    } else {
                      Get.put(AuthController()).logout();
                    }
                  }, color: Colors.red),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppTheme.primaryColor),
      title: Text(title,
          style: TextStyle(
              color: color ?? AppTheme.textPrimary,
              fontWeight: FontWeight.w500)),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }
}
