import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_workers_app/authentication/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class example extends StatefulWidget {
  final type;
  const example({Key? key, this.type}) : super(key: key);

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {
  List<Map<String, dynamic>> data = [];
  void dispose() {
    data.clear();
    super.dispose();
  }

  bool? setvalue;
  bool? remove;
  var usesr;
  Future<List<Map<String, dynamic>>> loaddata() async {
    usesr = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection('Worker')
        .get()
        .then((docs) async {
      for (var doc in docs.docs) {
        data.add(doc.data());
      }
      print(data);
    });
    return data;
    throw {};
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: FutureBuilder(
          future: loaddata(),
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.vertical,
          //   itemCount: data.length,
          //   itemBuilder: (context, position) {
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            var list = snapshot.data;
            // print(list);

            return SingleChildScrollView(
              child: Column(
                children: List.generate(list!.length, (index) {
                  List item = list[index]["useremail"];
                  item.contains(usesr) ? setvalue = true : setvalue = false;
                  return widget.type == list[index]["work"]
                      ? Container(
                          margin: EdgeInsets.only(right: 10, left: 16, top: 10),
                          height: 180,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Card(
                            shadowColor: Colors.grey,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "Name: ",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                list[index]["Name"].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      text: "Email: ",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                list[index]["email"].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      text: "Profession: ",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                list[index]["work"].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                list[index]["email"]!=usesr?  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () async {
                                          if (!item.contains(usesr)) {
                                          item.add(usesr);
                                            await FirebaseFirestore.instance
                                                .collection('Worker')
                                                .doc(list[index]["email"]
                                                    .toString())
                                                .update({"useremail": item});
                                            setState(() {
                                              setvalue = true;
                                            });
                                          } else {}
                                        },
                                        child:  Text(
                                                'Request',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            
                                      ),
                                      SizedBox(width: 6),
                                      setvalue == true
                                          ? OutlinedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  remove = item.remove(usesr);
                                                });
                                                if (remove == true) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Worker')
                                                      .doc(list[index]["email"]
                                                          .toString())
                                                      .update(
                                                          {"useremail": item});
                                                } else {}
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                          : SizedBox(),
                                    ],
                                  ):SizedBox(),
                                  // Text(
                                  //   data[position]['email'].toString(),
                                  //   style: TextStyle(
                                  //       fontSize: 22.0,
                                  //       color: Colors.black,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox();
                  // ]).expand((element) => element).toList()
                }).toList(),
              ),
            );
          }
          // }),
          ),
    );
  }
}
