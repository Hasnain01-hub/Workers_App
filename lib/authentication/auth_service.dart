import 'package:flutter/material.dart';
import 'package:new_workers_app/generic_classes/user.dart';
import 'firebase_auth_service.dart';

abstract class AuthService {
  FirebaseAuthService getCurrentUser();
  Stream<UserModel> get onAuthStateChanged;
  Future<UserModel> createUser(
    BuildContext context,
    String email,
    String password,
    String displayName,
  );
  Future<UserModel> signInWithEmailPassword(String email, String password);
  Future<UserModel> signInWithGoogle(BuildContext context);
  Future<void> sendPasswordResetEmail(String email);
  Future signOutUser();
  UserModel? currentUser();
  void dispose();
}
