class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    this.photoUrl,
    required this.displayName,
    required this.phoneNumber,
    // required this.role,
  });

  final String uid;
  final String? email;
  final String? photoUrl;
  final String? displayName;
  final String? phoneNumber;
  // final String? role;
}
