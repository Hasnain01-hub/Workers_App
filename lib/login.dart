import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_app/worker/Admin_home.dart';
import 'package:workers_app/Ask%20for%20worker/askfWorker.dart';
import 'package:workers_app/Home/home.dart';
import 'package:workers_app/signup.dart';


import 'User.dart';
import 'authentication/firebase_auth_service.dart';

class login extends StatefulWidget {

  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var name="";
var res;
var value;
  bool pre=false;
  bool pressed =true;
  UserModel? user2;
  TextEditingController? email =  TextEditingController();
  TextEditingController? password =  TextEditingController();
  final formKey = GlobalKey<FormState>();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email!.dispose();
    password!.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
          child: SingleChildScrollView(

            child: Form(
              key: formKey,
              child: Column(


                children: [


                  SizedBox(height: 90.0,),
                   Container(
                     alignment: Alignment.topCenter,
                       child: Image.asset("asset/login.gif",width: 260.0,height: 320.0,)),
Text("Welcome $name",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple,fontSize: 30.0),),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(left:30.0,right: 30.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                    labelText: 'Email',

      enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      hintText: 'Enter Email',
      hintStyle: TextStyle(color: Colors.grey),

      ),

      controller: email,
      validator: (String? value) {
      if (value!.isEmpty) {
      return 'Email is Required';
      }
      return null;
      },
      onChanged: (String value) {

        setState(() {
          name = value.split('@')[0];

        });
      },
      ),
                  ),
                  SizedBox(height: 20.0,),

                  Padding(
                    padding: const EdgeInsets.only(left:30.0,right: 30.0),
                    child: TextFormField(
                      obscureText:pressed,

                      decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap:(){
                          setState(() {
                            pressed=!pressed;
                          });
                        },
                        child: Icon(
                          pressed? Icons.visibility_off:Icons.remove_red_eye,
                          color: pressed?Colors.grey:Colors.blue,
                        ),
                      ),
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(

                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),

                      controller: password,
                      validator: (String? value) {
                      if (value!.isEmpty) {
                      return 'Password is Required';
                      }
                      return null;
                      },
                      onChanged: (String value) {


                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
InkWell(
  onTap:() async{
    if (formKey.currentState!.validate()) {
      print("pressed");




          final authServiceProvider =
          Provider.of<FirebaseAuthService>(context, listen: false);

          // Login the user
          var authUser = await authServiceProvider.signInWithEmailPassword(
              email!.text, password!.text);

          if (authUser.email != null) {
            var role;
            final CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
            users.doc(email.toString()).get().then(

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

          }else{
            SnackBar(
                content: const Text('Failed to loginIn'),
                action: SnackBarAction(
                  label: 'Register First!',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/Register", (route) => false);
                    // Some code to undo the change.
                  },
                ));
          }

    }
      // setState(() {
        res!=null ?pre = false:pre=true;
      // });
      await Future.delayed( Duration(seconds: 1));

    },


  child:   AnimatedContainer(
    height: 40,
    duration: Duration(seconds: 1),
    width:pre?39: 90,
  alignment: Alignment.center,
    child:pre?Icon(Icons.check,color: Colors.white,):
    Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
    decoration: BoxDecoration(
        color: Colors.deepPurple,
      borderRadius: BorderRadius.circular(pre?40:10)
    ),
  ),
),
                  SizedBox(height:5.0),
                  InkWell(
                    onTap: () async {
                      final authServiceProvider =
                      Provider.of<FirebaseAuthService>(context, listen: false);

                      // Login the user
                     await authServiceProvider.signInWithGoogle(context);
                      // if (user != null) {
                      //   Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //       builder: (context) => homePage(
                      //
                      //       ),
                      //     ),
                      //   );
                      // }
                    },
                    child: Ink(
                      color: Color(0xFF397AF3),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.android), // <-- Use 'Image.asset(...)' here
                            SizedBox(width: 12),
                            Text('Sign in with Google'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:10.0),
                  OutlinedButton(
                    style: ButtonStyle(elevation: MaterialStateProperty.all(0),shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: (){
setState(() {
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => signup()));
});

                  }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),)

                ],
              ),
            ),
          ),

      ),
    );
  }
}


