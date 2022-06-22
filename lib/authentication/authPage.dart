import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_app_new/generic_classes/user.dart';
import 'package:workers_app_new/screens/homepage.dart';
import 'package:workers_app_new/screens/loginPage.dart';
import 'firebase_auth_service.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServiceProvider = Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<UserModel>(
      stream: authServiceProvider.onAuthStateChanged,
      builder: (_, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        } else {
          final user = snapshot.data;
          return user == null ? LoginPage() : HomePage();
        }
      },
    );
  }
}
