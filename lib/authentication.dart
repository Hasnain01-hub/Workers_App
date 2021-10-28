import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthenticationHelper1{
  final FirebaseAuth firebaseAuth;
  //FirebaseAuth instance
  AuthenticationHelper1(this.firebaseAuth);
  Stream<User?> get authState => firebaseAuth.idTokenChanges();
}
class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;


  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final usersRef =
      FirebaseFirestore.instance.collection('Users').doc(email);
      usersRef.get().then((docSnapshot) => {
        if (!docSnapshot.exists)
          {
            usersRef
                .set({
              "name": email.split("@")[0],
              "email": email,
              // creating empty "urls" array in FireStore to store Storage urls

              "role": "user",
            })
                .then((value) => print("User's Document Added"))
                .catchError((error) => print(
                "Failed to add user: $error")) // create the document
          }
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}