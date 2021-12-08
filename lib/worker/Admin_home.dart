import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:workers_app/Ask%20for%20worker/Registerform.dart';
import 'package:workers_app/authentication/firebase_auth_service.dart';

import 'package:workers_app/login.dart';

import 'Profile/Profilemenu.dart';
import 'Profile/profile_pic.dart';




class wokerPage extends StatefulWidget {
  const wokerPage({Key? key}) : super(key: key);

  @override
  _wokerPageState createState() => _wokerPageState();
}

class _wokerPageState extends State<wokerPage> {
  late List<bool> isSelected;

  @override
  void initState() {
    final CollectionReference users =
    FirebaseFirestore.instance.collection('Worker');
    users.doc(user.email).get().then(

            (DocumentSnapshot documentSnapshot) async {
          final newPet = (documentSnapshot.data() as Map<String,
              dynamic>);
          print(newPet["status"]);
          if (newPet["status"]=="free") {
            isSelected = [true, false];
          } else {
            isSelected = [false, true];
            // Fluttertoast.showToast(msg: "Sign in successful!");
          }

            });
    // isSelected = [true, false];
    super.initState();
  }

  @override

  // void initState() {
  //   super.initState();
  //   getDriversList().then((results) {
  //     // setState(() {
  //       querySnapshot = results;
  //     // });
  //   });
  // }

  QuerySnapshot? querySnapshot;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  int page = 0;
  // var id= customAlphabet('456798123',2);
  // var rng = new Random();
  // var rand=id+rng.nextInt(1000);
  var uuid = Uuid();

  bool press=false;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Workers Side",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,


      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.search, size: 30, ),
          Icon(Icons.request_page, size: 30),
          Icon(Icons.account_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            page = index;

            print(page);
          });
        },
      ),

      body: condit(page),

    );
  }

  // getDriversList() async {
  //   return await FirebaseFirestore.instance.collection('Users').get();
  // }

  // Future loadGroups() async {
  //   return await FirebaseFirestore.instance
  //       .collection("Worker").get();
  // }
  condit(int index) {
    if (index == 0) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: Center(child: Text("Workers List",style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black,fontStyle: FontStyle.italic)),),
          ),
          StreamBuilder<QuerySnapshot <Map<String,dynamic>>>(
              stream: FirebaseFirestore.instance.collection('Worker').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  // final docData = snapshot.data;

                  return ListView.builder(
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.only(top: 10,left:10,right: 10),

                      itemCount: snapshot.data!.docs.length,
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        var rand=uuid.v1();
                        var temp = snapshot.data!.docs[index].data();
                        return Container(
                          margin: EdgeInsets.only( top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.5,
                                blurRadius: 6,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Material(
                              elevation: 1.5,

                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding:EdgeInsets.only(left: 16),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Name: ",
                                                style: TextStyle(
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColorDark,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: temp["Name"]
                                                          .toUpperCase()),
                                                ]),

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(left: 16,top: 12),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Profession: ",
                                                style: TextStyle(
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColorDark,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: temp["Work"]
                                                          .toUpperCase()),
                                                ]),

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(left: 16,top: 12),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Pin Code: ",
                                                style: TextStyle(
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColorDark,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: temp["PinCode"]
                                                          .toUpperCase()),
                                                ]),

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(left: 16,top: 12),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Status: ",
                                                style: TextStyle(
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColorDark,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: temp["status"]
                                                          .toUpperCase()),
                                                ]),

                                          ),
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                      if( temp["email"]!=user.email)...[
                                          Padding(
                                            padding:EdgeInsets.only(right: 19,top: 12),
                                            child: Align(
                                              alignment: Alignment.bottomRight,

                                              child: ElevatedButton(

                                                style: ButtonStyle( backgroundColor:temp["press"]=="true"?MaterialStateProperty.all<Color>(Colors.white):MaterialStateProperty.all<Color>(Colors.deepPurple),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(7.0),
                                                        side: BorderSide(color: Colors.white24)
                                                    )),

                                                ), onPressed: () {
                                                setState(() {
                                                  if(temp["press"]=="false"){
                                                    press=true;
                                                    FirebaseFirestore.instance
                                                        .collection("Request")
                                                        .doc(rand)
                                                        .set({
                                                      "email": temp["email"],
                                                      "useremail":user.email,
                                                      "Phone": temp["Phone"],
                                                      "Work": temp["Work"],
                                                      "Pin Code": temp["PinCode"],
                                                      "id":rand,
                                                      "Name": temp["Name"],
                                                      // "PinCode": Pin_code.text,
                                                      // "role": "Worker",
                                                    }).then((value) => print("User's Document Added"))
                                                        .catchError((error) => print(
                                                        "Failed to add user: $error"));
                                                    FirebaseFirestore.instance
                                                        .collection("Worker")
                                                        .doc(temp['email']).update({"press":"true","id":rand});}
                                                  else {
                                                    // FirebaseFirestore.instance
                                                    //     .collection("Worker")
                                                    //     .doc(temp['email']).update({"press":"false"});}
                                                    // null
                                                  }


                                                });

                                              }, child:temp["press"]=="true"? Text("Requested",style: TextStyle(color:Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 18),):Text("Request",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) ,
                                              ),
                                            ),
                                          ),
                                          ],

                                          if(temp["press"]=="true" && temp["email"]!=user.email)...[
                                            Padding(
                                              padding:EdgeInsets.only(right: 19,top: 12),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: ElevatedButton(
                                                  style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.redAccent.shade700),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(7.0),
                                                          side: BorderSide(color: Colors.white24)
                                                      )),

                                                  ), onPressed: () {
                                                  setState(() {
                                                    // press=false;
                                                    FirebaseFirestore.instance
                                                        .collection("Request")
                                                        .doc(temp['id']).delete();
                                                    FirebaseFirestore.instance
                                                        .collection("Worker")
                                                        .doc(temp['email']).update({"press":"false"});
                                                  });
                                                }, child: Text("Delete",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) ,
                                                ),
                                              ),
                                            ),
                                          ]
                                          // }
                                        ],
                                      )

                                    ]

                                ),
                              )
                          ),
                        );
                      }
                  );
                } else {
                  return Center(
                    child: Center(child: Text("No Worker Record")),
                  );
                }

              }),
        ],
      );

    }






    else if(index==1){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: Center(child: Text("Request List",style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black,fontStyle: FontStyle.italic)),),
          ),
          StreamBuilder<QuerySnapshot <Map<String,dynamic>>>(
              stream: FirebaseFirestore.instance.collection('Request').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  // final docData = snapshot.data;

                  return ListView.builder(
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.only(top: 10,left:10,right: 10),

                      itemCount: snapshot.data!.docs.length,
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        var temp = snapshot.data!.docs[index].data();
                        // var da=querySnapshot!.docs[index].data();
                        return Container(
                          margin: EdgeInsets.only( top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.5,
                                blurRadius: 6,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Material(
                              elevation: 1.5,

                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      if (temp["useremail"] == user.email) ...[
                                        Padding(
                                          padding:EdgeInsets.only(left: 16),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Name: ",
                                                  style: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColorDark,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: temp["Name"]
                                                            .toUpperCase()),
                                                  ]),

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:EdgeInsets.only(left: 16,top: 12),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Profession: ",
                                                  style: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColorDark,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: temp["Work"]
                                                            .toUpperCase()),
                                                  ]),

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:EdgeInsets.only(left: 16,top: 12),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Pin Code: ",
                                                  style: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColorDark,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: temp["Pin Code"]
                                                            .toUpperCase()),
                                                  ]),

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:EdgeInsets.only(left: 16,top: 12),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Phone No: ",
                                                  style: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColorDark,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: temp["Phone"]
                                                            .toUpperCase()),
                                                  ]),

                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 7.0,),
                                        Padding(
                                          padding:EdgeInsets.only(left: 16,top: 12),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Request From: ",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: temp["useremail"]
                                                            .toUpperCase()),
                                                  ]),

                                            ),
                                          ),
                                        ),

                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: 19,top: 12),
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: temp["accept"]=="Accept"?  ElevatedButton(
                                                    style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.white),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7.0),
                                                            side: BorderSide(color: Colors.white24)
                                                        )),

                                                    ), onPressed: () {
                                                    setState(() {
                                                      // press=false;
                                                      FirebaseFirestore.instance
                                                          .collection("Request")
                                                          .doc(temp['id']).update({"accept":"Accept"});
                                                      // FirebaseFirestore.instance
                                                      //     .collection("Worker")
                                                      //     .doc(temp['email']).update({"press":"false"});
                                                    });
                                                  }, child: Text("Accept",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 18),) ,
                                                  ):null,
                                                ),
                                              ),
                                              // if(press==true)...[
                                              Padding(
                                                padding:EdgeInsets.only(right: 19,top: 12),
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.redAccent.shade700),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7.0),
                                                            side: BorderSide(color: Colors.white24)
                                                        )),

                                                    ), onPressed: () {
                                                    setState(() {
                                                      // press=false;
                                                      FirebaseFirestore.instance
                                                          .collection("Request")
                                                          .doc(temp['id']).delete();
                                                      FirebaseFirestore.instance
                                                          .collection("Worker")
                                                          .doc(temp['email']).update({"press":"false"});
                                                    });
                                                  }, child: Text("Delete",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) ,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          // }
                                          // ],
                                        )
                                      ]
                                    // ]

                                ]),
                              )
                          ),
                        );
                      }
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

              }),

        ],
      );

    }else if(index==2){
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),

            Row(

              children: [
                SizedBox(width: 20),
                Text("Status: ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                SizedBox(width: 16),
                ToggleButtons(
                  borderColor: Colors.black,
                  fillColor: Colors.grey,
                  borderWidth: 2,
                  selectedBorderColor: Colors.black,
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Free',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Busy',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }

                      if(index==0){
                        FirebaseFirestore.instance
                            .collection("Worker")
                            .doc(user.email).update({"status":"free"});

                      }else{
                        FirebaseFirestore.instance
                            .collection("Worker")
                            .doc(user.email).update({"status":"busy"});

                      }
                    });
                  },
                  isSelected: isSelected,
                ),
              ],
            ),
            ProfileMenu(
              text: user.email.toString(),
              icon: "asset/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Register for worker",
              icon: "asset/Bell.svg",
              press: () {Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Registerform()));},
            ),

            // ProfileMenu(
            //   text: "Help Center",
            //   icon: "assets/icons/Question mark.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Log Out",
              icon: "asset/Log out.svg",
              press: () {
                setState(() {

                  FirebaseAuthService().signOutUser().then((result){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => login()));
                  });

                });

              },
            ),
          ],
        ),
      );
    }
  }

}

// ListView(
// children: snapshot.data!.docs.map((doc) {
// return ClipRRect(
// borderRadius: BorderRadius.circular(10),
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Card(
// child: ListTile(
// title: RichText(
// text: TextSpan(
// text: "Name: ",
// style: TextStyle(
// color: Theme.of(context)
//     .primaryColorDark,
// fontSize: 15,
// fontWeight: FontWeight.w700,
// ),
// children: <TextSpan>[
// TextSpan(
// text: doc.data()["Name"]
//     .toUpperCase()),
// ]),
// ),
//
//
//
// // Text(doc.data()!["Name"],style: TextStyle(color:Colors.black),),
// ),
// ),
// ),
// );
// }).toList(),
// );