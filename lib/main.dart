import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workers_app_new/screens/homepage.dart';
import 'package:workers_app_new/screens/loginPage.dart';
import 'package:workers_app_new/screens/myProfileScreen.dart';
import '../screens/setProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/firebase_auth_service.dart';
import 'generic_classes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
