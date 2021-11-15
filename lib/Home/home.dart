import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:workers_app/Ask%20for%20worker/Registerform.dart';
import 'package:workers_app/authentication.dart';
import 'package:workers_app/login.dart';

import '../Profile/Profilemenu.dart';
import '../Profile/profile_pic.dart';


class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  int page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Workers App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
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



                                 ]

                             ),
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

     }






     else if(index==1){
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Text(
                "Request worker"
            )
          ]
      );

    }else if(index==2){
       return SingleChildScrollView(
         padding: EdgeInsets.symmetric(vertical: 20),
         child: Column(
           children: [
             ProfilePic(),
             SizedBox(height: 20),
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

                       AuthenticationHelper().signOut().then((result){
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