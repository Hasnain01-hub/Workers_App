class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    this.photoUrl,
    this.isWorker,
    required this.displayName,
    required this.phoneNumber,
  });

  final String uid;
  final String? email;
  final String? photoUrl;
  final String? displayName;
  final String? isWorker;
  final String? phoneNumber;
}
