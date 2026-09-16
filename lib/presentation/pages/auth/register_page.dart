import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Join EyeCare Connect',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Select role & create account',
                style: TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 20),
            Obx(() => Row(
                  children: [
                    _chip(AppConstants.roleDonor, 'Eye Donor',
                        Icons.remove_red_eye_outlined),
                    const SizedBox(width: 8),
                    _chip(AppConstants.roleHospital, 'Hospital',
                        Icons.local_hospital_outlined),
                    const SizedBox(width: 8),
                    _chip(AppConstants.roleAdmin, 'Admin',
                        Icons.admin_panel_settings_outlined),
                  ],
                )),
            const SizedBox(height: 20),
            TextField(
              controller: controller.regName,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.regEmail,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email *',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.regPhone,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone *',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            Obx(() {
              if (controller.selectedRole.value != AppConstants.roleHospital) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller.regHospital,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Hospital / Eye Bank Name *',
                      prefixIcon: Icon(Icons.business_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller.regAddress,
                    textInputAction: TextInputAction.next,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),
            Obx(() => TextField(
                  controller: controller.regPassword,
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(controller.showPassword.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.togglePassword,
                    ),
                  ),
                )),
            const SizedBox(height: 28),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.register,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('Create Account'),
                )),
          ],
        ),
      ),
    );
  }

  Widget _chip(String role, String label, IconData icon) {
    final selected = controller.selectedRole.value == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedRole.value = role,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppTheme.primaryColor.withOpacity(0.12)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppTheme.primaryColor : AppTheme.dividerColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: 22,
                  color: selected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondary),
              const SizedBox(height: 4),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected
                        ? AppTheme.primaryColor
                        : AppTheme.textSecondary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
