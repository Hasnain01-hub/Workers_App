import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:workers_app/Ask%20for%20worker/Registerform.dart';
import 'package:workers_app/authentication.dart';
import 'package:workers_app/login.dart';

import 'Profile/Profilemenu.dart';
import 'Profile/profile_pic.dart';


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




   condit(int index){
     if (index==0){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

            children: [

            Text(
              "search worker"
            )
    ]
    );


    }else if(index==1){
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

// final List<Widget> tabItems = [
// Widget Request(){
//
//   return Column(
//     children: [
//       OutlinedButton(onPressed:(){
//         setState(() {
//           AuthenticationHelper().signOut().then((result){
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => login()));
//           });
//         });
//
//       }, child: Text("logout"))
//     ],
//
//   );
//
//
//
//   ];
//

 }

