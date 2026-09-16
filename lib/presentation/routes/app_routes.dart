class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  // Donor
  static const donorHome = '/donor-home';
  static const donorRegister = '/donor-register';
  static const donorCard = '/donor-card';
  static const donationStatus = '/donation-status';
  static const profile = '/profile';

  // Hospital
  static const hospitalHome = '/hospital-home';
  static const searchDonor = '/search-donor';

  // Admin
  static const adminHome = '/admin-home';
  static const manageUsers = '/manage-users';
  static const manageHospitals = '/manage-hospitals';
  static const reports = '/reports';

  // Aliases (পুরনো নাম support — error fix)
  static const donorDashboard = donorHome;
  static const donorRegistration = donorRegister;
  static const hospitalDashboard = hospitalHome;
  static const adminDashboard = adminHome;
  static const generateReports = reports;
}
