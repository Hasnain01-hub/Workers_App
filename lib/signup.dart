import 'package:flutter/material.dart';
import 'package:workers_app/Ask%20for%20worker/askfWorker.dart';
import 'package:workers_app/Home/home.dart';
import 'package:workers_app/login.dart';

import 'authentication.dart';

class signup extends StatefulWidget {

  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  var name="";

  bool pre=false;
  bool pressed =true;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                    child: Image.asset("asset/signup.gif",width: 260.0,height: 320.0,fit: BoxFit.fitHeight,)),
                Text("Register ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple,fontSize: 30.0),),
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
                      setState(() {
                        pre = true;
                      });


                      AuthenticationHelper()
                          .signUp(email: email.text.trim(), password: password.text.trim())
                          .then((result) {
                        if (result == null) {

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Askfworker()));
                        } else {
                          print(email.text+""+password.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      });
                      await Future.delayed( Duration(seconds: 1));

                    }

                  },
                  child:   AnimatedContainer(
                    height: 40,
                    duration: Duration(seconds: 1),
                    width:pre?39: 90,
                    alignment: Alignment.center,
                    child:pre?Icon(Icons.check,color: Colors.white,):
                    Text("Register",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(pre?40:10)
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
      MaterialPageRoute(builder: (context) => login()));
});

                }, child: Text("login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),)
              ],
            ),
          ),
        ),

      ),
    );
  }
}




