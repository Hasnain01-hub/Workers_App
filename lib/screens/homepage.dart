import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Workers App"),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      body: Text("Home"),
    );
  }
}
