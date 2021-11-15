import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workers_app/Home/home.dart';
class Registerform extends StatefulWidget {
  const Registerform({Key? key}) : super(key: key);

  @override
  _RegisterformState createState() => _RegisterformState();
}

class _RegisterformState extends State<Registerform> {
  @override
  bool pre=false;
  TextEditingController Name = new TextEditingController();
  TextEditingController Work = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  TextEditingController Phone = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController Aadhar_No = new TextEditingController();
  TextEditingController Address = new TextEditingController();
  TextEditingController Pin_code = new TextEditingController();
  static const menuItems = <String>[
    'Electrician',
    'Carpenter',
    'Welding',
    'Plumber',
    'Masonry',
  ];
  String? btnSelectedVal;
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  ).toList();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: 'Back',
        onPressed: () {
          setState(() {
            Navigator.pop(context);
          });
        },
      ),title: Center(child: Text("Register form",style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold),
    )
        ,),
    ),
      body:SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.grey),

                  ),

                  controller: Name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name is Required';
                    }
                    return null;
                  },
                  onChanged: (String value) {

                    setState(() {


                    });
                  },
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone NO',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Enter Phone',
                    hintStyle: TextStyle(color: Colors.grey),

                  ),

                  controller: Phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone No is Required';
                    }
                    return null;
                  },
                  // onChanged: (String value) {
                  //
                  //   Phone=value;
                  // },
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Aadhar NO',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Enter Aadhar NO',
                    hintStyle: TextStyle(color: Colors.grey),

                  ),

                  controller: Aadhar_No,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Aadhar NO is Required';
                    }
                    return null;
                  },
                  onChanged: (String value) {

                    // setState(() {
                    //   name = value.split('@')[0];
                    //
                    // });
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Enter Address',
                    hintStyle: TextStyle(color: Colors.grey),

                  ),

                  controller: Address,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Address is Required';
                    }
                    return null;
                  },
                  onChanged: (String value) {

                    // setState(() {
                    //   name = value.split('@')[0];
                    //
                    // });
                  },
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pin Code',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(color: Colors.grey),

                  ),

                  controller: Pin_code,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Pin Code is Required';
                    }
                    return null;
                  },
                  onChanged: (String value) {

                    // setState(() {
                    //   name = value.split('@')[0];
                    //
                    // });
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Select Profession',style:TextStyle(color: Colors.grey.shade800)),
                    SizedBox(width: 10.0,),
                    DropdownButton<String>(
                      value: btnSelectedVal,
                      hint: Text('Choose'),
                      items: this._dropDownMenuItems,
                      onChanged: (String? newvalue){
                        setState(() {
                          btnSelectedVal =newvalue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
    if (formKey.currentState!.validate()) {

      setState(() {
        Map<String, dynamic> worker = {
          "role":"worker",

        };
          pre = true;
          FirebaseFirestore.instance
              .collection("Worker")
              .doc(user.email)
        .set({
    "Name": Name.text,
    "Phone": Phone.text,
    "Work": btnSelectedVal,
    "Address": Address.text,
    "Aadhar": Aadhar_No.text,
    "PinCode": Pin_code.text,
    "role": "Worker",
    }).then((value) => print("User's Document Added"))
        .catchError((error) => print(
    "Failed to add user: $error"));
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.email).update({"role":"Worker"});
    });


          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => homePage()));

      await Future.delayed(Duration(seconds: 1));
    }
                    },
                    child: AnimatedContainer(

                      height: 47,

                      duration: Duration(seconds: 1),
                      width:pre?47: 250,
                      alignment: Alignment.center,
                      child:pre?Icon(Icons.check,color: Colors.white,):
                      Text("Submit"
                        ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.0),),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(pre?40:10)
                      ),

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
    }
}
