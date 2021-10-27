import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';




class ProfilePic extends StatelessWidget {
   ProfilePic({
    Key? key,
  }) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;
  @override

  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [

          CircleAvatar(
            backgroundImage: AssetImage("asset/u1.png"),
            radius: 100,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: Icon(Icons.account_circle,color: Colors.black54,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
