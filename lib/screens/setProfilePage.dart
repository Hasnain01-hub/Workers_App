import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_workers_app/authentication/firebase_auth_service.dart';
import 'package:new_workers_app/generic_classes/inputWithIcon.dart';
import 'package:new_workers_app/generic_classes/primaryButton.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key? key}) : super(key: key);

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final phoneNumber = TextEditingController();
  bool isWorker = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
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
                    child: Text(
                      "Additional Details",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 25, left: 10, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Image.asset(
                        "assets/images/login.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  InputWithIcon(
                    btnIcon: Icons.phone,
                    hintText: "Phone",
                    myController: phoneNumber,
                    onChange: (String value) {},
                    keyboardType: TextInputType.number,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return "Phone Required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  CheckboxListTile(
                    title: Text("Register as a worker"),
                    value: isWorker,
                    onChanged: (newValue) {
                      setState(() {
                        isWorker = !isWorker;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  PrimaryButton(
                    btnText: "Continue",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final authUser = Provider.of<FirebaseAuthService>(
                                context,
                                listen: false)
                            .currentUser();
                        CollectionReference users =
                            FirebaseFirestore.instance.collection('Users');
                        users.doc(authUser!.email).update({
                          "phone": phoneNumber.text,
                          "isWorker": isWorker,
                        }).catchError(
                            (error) => print("Failed to update user: $error"));
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                      }
                    },
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
