class AppConstants {
  static const String roleDonor = 'donor';
  static const String roleHospital = 'hospital';
  static const String roleAdmin = 'admin';

  static const List<String> bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  static String roleLabel(String role) {
    switch (role) {
      case roleHospital:
        return 'Hospital / Eye Bank';
      case roleAdmin:
        return 'Admin';
      default:
        return 'Eye Donor';
    }
  }
}
