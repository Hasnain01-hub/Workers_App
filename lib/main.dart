import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_app/Ask%20for%20worker/askfWorker.dart';
import 'package:workers_app/worker/Admin_home.dart';
import 'package:workers_app/Home/home.dart';
import 'package:workers_app/authentication/authPage.dart';
import 'package:workers_app/signup.dart';




import 'authentication/firebase_auth_service.dart';
import 'login.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()); // define it once at root level.
  }
}
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(

        // backgroundColor: Colors.red,
        body: Image.asset("asset/Launch.png",fit: BoxFit.cover,alignment: Alignment.center,repeat: ImageRepeat.noRepeat,),
      ),
    );
  }
}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
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
        
    routes: {
      "/adminHome": (context) => wokerPage(),
      "/Register": (context) => signup(),
      "/login": (context) => login(),
      "/Home": (context) => homePage(),
      "/askworker": (context) => Askfworker(),
    },
        // debugShowCheckedModeBanner: false,
        title: 'Workers App',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: AuthPage(),
      ),
    );
  }
}

