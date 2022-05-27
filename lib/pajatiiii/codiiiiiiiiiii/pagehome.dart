// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';

class Pagehoume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Button"),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Color.fromARGB(255, 109, 92, 112),
            ),
            onPressed: () {},
          ),
        ));
    ElevatedButton(
      child: Text("Button"),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.purple,
      ),
      onPressed: () {},
    );
  }
}
