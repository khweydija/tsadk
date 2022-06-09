// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tsdak/CRUD/Donfamillies.dart';
import '../../CRUD/don.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: const Text(" Don de seng "),
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        height: 230,
        width: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 93, 104, 93),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "Si vous voulez donner votre sang cliquez sur Donneur ,Si vous avez besoin de don de seng cliquez sur chercheur",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => Done()));
                  },
                  child: Text("Donneur"),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 122, 76, 76)),
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("chercheur")))
              ],
            )
          ],
        ),
      )),
    );
  }
}
