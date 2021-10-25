import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:workers_app/authentication.dart';
import 'package:workers_app/login.dart';

import 'account.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  int page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
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
    setState(() {page = index;
    if(index==2){
      setState(() {
        Account();
      });

    }

    print(page);
    });
    },
    ),

    body: Container(

      child:Account(),)
    );
  }
  Widget Account(){

    return Column(
        children: [
          OutlinedButton(onPressed:(){
            setState(() {
              AuthenticationHelper().signOut().then((result){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => login()));
              });
            });

          }, child: Text("logout"))
        ],

    );
  }
}
