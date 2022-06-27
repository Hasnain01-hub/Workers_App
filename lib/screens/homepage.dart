// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_workers_app/generic_classes/categoryListView.dart';
import 'package:new_workers_app/generic_classes/header.dart';
import 'package:new_workers_app/generic_classes/homeComponents.dart';
import 'package:new_workers_app/generic_classes/neuroBox.dart';
import 'package:new_workers_app/generic_classes/workerCard.dart';
import 'package:new_workers_app/screens/sideBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Workers App"),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.grey[300],
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            MainComponent(),
            const SizedBox(
              height: 16,
            ),
            Header("Categories"),
            const SizedBox(
              height: 16,
            ),
            CategoryListView(
              callBack: () {
                moveTo();
              },
            ),
            SizedBox(
              height: 16,
            ),
            Header("Worker Card"),
            Padding(
              padding: EdgeInsets.all(25),
              child: NeuroMorphicBox(
                child: WorkerCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveTo() {
    // to throw search page by selecting category
  }
}
