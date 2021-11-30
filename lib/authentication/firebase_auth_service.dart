import 'package:workers_app/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workers_app/worker/Admin_home.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  // UserModel is a custom Class which we made in user.dart
  // User is a firebase Auth class which comes inbuilt with firebase_auth package.

  UserModel _userFromFirebase(User? user) {
    return UserModel(
      uid: user!.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,

    );
  }

  @override
  FirebaseAuthService getCurrentUser() {
    return this;
  }

  @override
  UserModel? currentUser() {
    final User? user = _firebaseAuth.currentUser;
    if (user != null)
      return _userFromFirebase(user);
    else
      return null;
  }

  @override
  Stream<UserModel> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserModel> createUser(BuildContext context, String email,
      String password, String displayName) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (result) async {
          final user = result.user;
          await user!.updateDisplayName(displayName);
          await createFirebaseDocument(_firebaseAuth.currentUser!);
          final usersRef =
          FirebaseFirestore.instance.collection('Users').doc(email);
          usersRef.get().then((docSnapshot) =>
          {
            if (!docSnapshot.exists)
              {
                usersRef
                    .set({
                  "name": email.split("@")[0],
                  "email": email,
                  // creating empty "urls" array in FireStore to store Storage urls
                  // "press": "false",
                  "role": "user",
                })
                    .then((value) => print("User's Document Added"))
                    .catchError((error) =>
                    print(
                        "Failed to add user: $error")) // create the document
              }
          });
          // Navigator.pushNamed(context, "/setProfile");
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Something went wrong, Try again!");
    }
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  @override
  Future<UserModel> signInWithEmailPassword(
      String email, String password) async {
    UserCredential? authResult;

    try {
      authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Email not found, create a new account!");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password. Try again!");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Something went wrong, Try again!");
    }

    return _userFromFirebase(authResult!.user);
  }

  @override
  Future<UserModel> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = authResult.user;
    var role;
    // add the users document if not ready
    users.doc(user!.email).get().then(

      (DocumentSnapshot documentSnapshot) async {
        final newPet = (documentSnapshot.data() as Map<String, dynamic>);
        print(newPet["role"]);
        if (!documentSnapshot.exists) {

          var data = documentSnapshot.data() ;

          // newPet.reference = documentSnapshot.reference.id;

        // role = data?['role'];
          await createFirebaseDocument(user);

          // Navigator.pushNamed(context, "/Home");
        } else if (newPet["role"]=="Worker") {
          Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => wokerPage(),
                  ));
        } else {
          Navigator.pushNamed(context, "/Home");
          Fluttertoast.showToast(msg: "Sign in successful!");
        }
      },
    );

    return _userFromFirebase(user);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) => Fluttertoast.showToast(
              msg: "Password Reset link sent to your email!",
              backgroundColor: Colors.indigo,
              textColor: Colors.white,
            ))
        .catchError((error) {
      if (error.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "Email not found, create a new account!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (error.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: "Invalid email",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    });
  }

  @override
  Future signOutUser() async {
    return _firebaseAuth.signOut();
  }

  Future<void> createFirebaseDocument(User user) {
    return users
        .doc(user.email)
        .set({
          "name": user.displayName,
          "email": user.email,
      "role":"user",
          "phoneFromAuth": user.phoneNumber ?? null,
          // creating empty wishlist array for storing favourite properties
          // "wishlist": [],
        })
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void dispose() {}

  Future<bool> isBroker() async {
    if (this.currentUser() != null) {
      final getBroker = await FirebaseFirestore.instance
          .collection("Users")
          .doc(this.currentUser()!.email)
          .get();
      return getBroker.data()!["isBroker"];
    } else {
      return false;
    }
  }
}
