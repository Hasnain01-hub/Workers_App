// ignore_for_file: prefer_const_constructors, file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:new_workers_app/generic_classes/primaryButton.dart';

class WorkerCard extends StatefulWidget {
  const WorkerCard({Key? key}) : super(key: key);

  @override
  State<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/images/login.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Worker Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Profession",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    PrimaryButton(
                      btnText: "View more",
                      onPressed: () {
                        // navigate to detail screen
                      },
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    //add to wishlist
                  },
                  icon: Icon(Icons.favorite),
                  color: Colors.redAccent,
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
