import 'package:get/get.dart';
import '../bindings/app_bindings.dart';
import '../pages/admin/admin_home.dart';
import '../pages/admin/manage_hospitals.dart';
import '../pages/admin/manage_users.dart';
import '../pages/admin/reports.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/donor/donation_status.dart';
import '../pages/donor/donor_card.dart';
import '../pages/donor/donor_home.dart';
import '../pages/donor/donor_register.dart';
import '../pages/hospital/hospital_home.dart';
import '../pages/hospital/search_donor.dart';
import '../pages/profile/profile_page.dart';
import '../pages/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.donorHome,
      page: () => const DonorHomePage(),
      binding: DonorHomeBinding(),
    ),
    GetPage(
      name: Routes.donorRegister,
      page: () => const DonorRegisterPage(),
      binding: DonorRegisterBinding(),
    ),
    GetPage(
      name: Routes.donorCard,
      page: () => const DonorCardPage(),
      binding: DonorCardBinding(),
    ),
    GetPage(
      name: Routes.donationStatus,
      page: () => const DonationStatusPage(),
      binding: DonationStatusBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.hospitalHome,
      page: () => const HospitalHomePage(),
      binding: HospitalHomeBinding(),
    ),
    GetPage(
      name: Routes.searchDonor,
      page: () => const SearchDonorPage(),
      binding: SearchDonorBinding(),
    ),
    GetPage(
      name: Routes.adminHome,
      page: () => const AdminHomePage(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: Routes.manageUsers,
      page: () => const ManageUsersPage(),
      binding: ManageUsersBinding(),
    ),
    GetPage(
      name: Routes.manageHospitals,
      page: () => const ManageHospitalsPage(),
      binding: ManageHospitalsBinding(),
    ),
    GetPage(
      name: Routes.reports,
      page: () => const ReportsPage(),
      binding: ReportsBinding(),
    ),
  ];
}
