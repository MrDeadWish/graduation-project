class Settings {
  final String siteUrl;
  final String phone;
  final String email;
  final String managerName;
  final String managerPhone;
  final String managerEmail;

  Settings({
    required this.siteUrl,
    required this.phone,
    required this.email,
    required this.managerName,
    required this.managerPhone,
    required this.managerEmail,
  });

  static Settings fromJson(Map<String, dynamic> json) {
    return Settings(
      siteUrl: json['site_url'].toString(),
      phone: json['phone'].toString(),
      email: json['email'].toString(),
      managerName: json['manager_name'].toString(),
      managerPhone: json['manager_phone'].toString(),
      managerEmail: json['manager_email'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site_url': siteUrl,
      'phone': phone,
      'email': email,
      'manager_name': managerName,
      'manager_phon': managerPhone,
      'manager_email': managerEmail,
    };
  }
}
