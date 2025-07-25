class User {
  String name;
  String email;
  String? password; // Add password field
  String? profileImagePath;
  double dailyLimit;

  User({
    required this.name,
    required this.email,
    this.password,
    this.profileImagePath,
    this.dailyLimit = 0.0,
  });
}
