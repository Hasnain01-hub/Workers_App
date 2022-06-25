import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_workers_app/generic_classes/inputWithIcon.dart';
import 'package:new_workers_app/screens/myProfileScreen.dart';
import 'package:lottie/lottie.dart';

class Complete_profile extends StatefulWidget {
  final email;
  Complete_profile({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<Complete_profile> createState() => _Complete_profileState();
}

class _Complete_profileState extends State<Complete_profile> {
  @override
  TextEditingController address = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController aadharNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0),
                    child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300],
                    ),
                      height: 40.0,
                      
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Additional Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: Container(
                        width: 180,
                        alignment: Alignment.topCenter,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:18.0),
                          child: Lottie.asset(
                            "assets/images/registration.json",
                            fit: BoxFit.fitHeight,
                            height: 120,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InputWithIcon(
                    btnIcon: Icons.phone,
                    hintText: "Aadhar no",
                    maxLength: 12,
                    myController: aadharNumber,
                    onChange: (String value) {},
                    keyboardType: TextInputType.number,
                    validateFunc: (value) {},
                  ),
                  SizedBox(height: 20),
                  InputWithIcon(
                    btnIcon: Icons.email,
                    hintText: "Pin Code",
                    maxLength: 6,
                    myController: pin,
                    onChange: (String value) {},
                    validateFunc: (value) {},
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  InputWithIcon(
                    btnIcon: Icons.work,
                    hintText: "Work Type",
                    myController: work,
                    onChange: (String value) {},
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  
                  InputWithIcon(
                    btnIcon: Icons.location_on,
                    hintText: "Address",
                    myController: address,
                    onChange: (String value) {},
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection("Worker")
                            .doc(widget.email)
                            .set({
                          "pin": pin.text,
                          "Address": address.text,
                          "Aadhar": aadharNumber.text,
                          "work":work.text,
                          "email":widget.email,
                          "Name":widget.email.toString().split("@")[0],
                          "status": "100",
                        }).then((Null) {
                          Navigator.popAndPushNamed(context, '/home');
                        });
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
