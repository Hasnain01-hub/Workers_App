// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class NeuroMorphicBox extends StatefulWidget {
  final child;
  const NeuroMorphicBox({Key? key,required this.child}) : super(key: key);

  @override
  State<NeuroMorphicBox> createState() => _NeuroMorphicBoxState();
}

class _NeuroMorphicBoxState extends State<NeuroMorphicBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Center(child: widget.child,),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:Colors.grey.shade500,
            blurRadius: 15,
            offset: Offset(5,5),
          ),
          BoxShadow(
            color:Colors.white,
            blurRadius: 15,
            offset: Offset(-5,-5),
          ),
        ]
      ),
    );
  }
}
