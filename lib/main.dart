import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_workers_app/screens/homepage.dart';
import 'package:new_workers_app/screens/loginPage.dart';
import 'package:new_workers_app/screens/myProfileScreen.dart';
import '../screens/setProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/firebase_auth_service.dart';
import 'generic_classes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCUpVwThyMI7MAjY8dZHTSB8CIVUFX9SkA",
            appId: "app-1-856711366235-ios-49c955fa8a17b0df5b617e",
            messagingSenderId: "Your Sender id found in Firebase",
            projectId: "workersapp-d922c"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        FutureProvider<bool>(
          create: (context) => FirebaseAuthService().isWorker(),
          initialData: false,
        ),
        FutureProvider<Map<String, dynamic>?>(
          create: (context) async {
            var user = Provider.of<FirebaseAuthService>(context, listen: false)
                .currentUser();
            var userDoc = await FirebaseFirestore.instance
                .collection("Users")
                .doc(user!.email)
                .get();
            return userDoc.data();
          },
          initialData: {},
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workers App',
        theme: basicTheme(),
        home: HomePage(),
        routes: {
          "/home": (context) => HomePage(),
          "/auth": (context) => LoginPage(),
          "/setProfile": (context) => SetProfilePage(),
          "/myProfile": (context) => MyProfileScreen(),
        },
      ),
    );
  }
}
