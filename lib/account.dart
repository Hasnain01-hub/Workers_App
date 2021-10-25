import 'package:flutter/material.dart';
import 'package:workers_app/authentication.dart';
import 'package:workers_app/login.dart';
class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(
        onTap:(){ Navigator.pop(context);},
        child: Icon(
           Icons.arrow_back,

        ),
      ),
     title: Text("Account"),
      ),
    body: Column(
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
    ),
    );

  }

}


