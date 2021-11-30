import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workers_app/worker/Admin_home.dart';
import 'package:workers_app/authentication/firebase_auth_service.dart';
import 'package:workers_app/User.dart';
import 'package:workers_app/Home/home.dart';
import 'package:workers_app/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var role;



    final authServiceProvider = Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<UserModel>(
      stream: authServiceProvider.onAuthStateChanged,
      builder: (_, AsyncSnapshot<UserModel> snapshot) {
        var role;
        final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
        users.doc(snapshot.data?.email).get().then(

                (DocumentSnapshot documentSnapshot) async {
                  final newPet = (documentSnapshot.data() as Map<String,
                      dynamic>);
                  print(newPet["role"]);
                  if (!documentSnapshot.exists) {
                    role = newPet["role"];
                    Navigator.pushNamed(context, "/Home");
                    } else if (newPet["role"]=="Worker") {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => wokerPage(),
                          ));
                    } else {
                      Navigator.pushNamed(context, "/Home");
                      // Fluttertoast.showToast(msg: "Sign in successful!");
                    }

                });

                // final firebaseUser = context.watch<User?>();
        // Future.delayed( Duration.zero, () async {
        //
        //   var collection = FirebaseFirestore.instance.collection('Users');
        //   var docSnapshot = await collection.doc(snapshot.data?.email).get();
        //   if (docSnapshot.exists) {
        //     Map<String, dynamic>? data = docSnapshot.data();
        //
        //     // You can then retrieve the value from the Map like this:
        //     role = data?['role'];
        //     print(role);
        //   }
        //   // print("Role is here::::::::::::::::::::::::::::::::::::::::::::::::"+role);
        // });

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
        }

        else if(snapshot.data==null){
          return login();
        }
        else {
          return homePage();
        }
       //  else if (role=="Worker") {
       // return wokerPage();
       //  }
       //  else {
       //   return homePage();
       //    // Fluttertoast.showToast(msg: "Sign in successful!");
       //  }

      },

    );
  }
}
