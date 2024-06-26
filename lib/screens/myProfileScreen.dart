import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:new_workers_app/authentication/firebase_auth_service.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}


class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  var setdata;
  void initState() {
  
    final CollectionReference users =
    FirebaseFirestore.instance.collection('Users');
    users.doc(user1.email).get().then(

            (DocumentSnapshot documentSnapshot) async {
          final newPet = (documentSnapshot.data() as Map<String,
              dynamic>);
          print(newPet["isWorker"]);
          setState(() {
            
          setdata = newPet["isWorker"];
          });
          // if (newPet["status"]=="free") {
          //   isSelected = [true, false];
          // } else {
          //   isSelected = [false, true];
          //   // Fluttertoast.showToast(msg: "Sign in successful!");
          // }

            });
    super.initState();
  }
  @override
    final FirebaseAuth _auth = FirebaseAuth.instance;
  get user1 => _auth.currentUser;
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    final authUser = Provider.of<FirebaseAuthService>(context).getCurrentUser();
    var userData = Provider.of<Map<String, dynamic>?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Theme.of(context).primaryColor),
            clipper: ProfileClipper(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: Column(
                children: <Widget>[
                  user != null
                      ? CircleAvatar(
                          radius: 75,
                          child: ClipOval(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    user.photoUrl ??
                                        "https://cdn.pixabay.com/photo/2016/04/01/10/11/avatar-1299805_960_720.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Text("PLease Login"),
                        ),
                  SizedBox(height: 30.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.user,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        user!.displayName ?? '',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.envelope,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        user.email ?? '',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.phoneAlt,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        userData!["phone"] ?? "Fetching phone no.",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                 setdata==true ?  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.userTie,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        "Option for Free/busy",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ) :SizedBox(),

                  SizedBox(height: 50.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        try {
                          authUser.signOutUser();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (Route<dynamic> route) => false);
                        } catch (e) {
                          print(e);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Logout Error"),
                                content: Text(
                                    "Some error occurred!\nYou are still logged In"),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: Text("Try Again"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Once you Logout, you won't be able to use some of the features, You have to Login again to continue with the app.",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 4);
    path.lineTo(size.width + 200, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
