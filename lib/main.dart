import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_app/home.dart';


import 'authentication.dart';

import 'login.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationHelper1>(
          create: (_) => AuthenticationHelper1(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationHelper1>().authState, initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workers App',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: Authenticate(),
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      //Means that the user is logged in already and hence navigate to HomePage
      return homePage();
    }
    //The user isn't logged in and hence navigate to SignInPage.
    return login();
  }
}