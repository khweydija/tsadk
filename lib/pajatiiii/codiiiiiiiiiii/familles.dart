// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tsdak/CRUD/Donfamillies.dart';
import '../../CRUD/don.dart';

class Familles extends StatefulWidget {
  const Familles({Key? key}) : super(key: key);

  @override
  State<Familles> createState() => _FamillesState();
}

class _FamillesState extends State<Familles> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: const Text("Familles Indigentes "),
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        height: 230,
        width: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 163, 168, 163),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "si vous voulez localiser des femmes en besoin d aide Cliquez sur Bénévole ,si vous avez besoin daide sociale cliquez sur chercheur ",
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
                        .push(MaterialPageRoute(builder: (c) => bb()));
                  },
                  child: Text("Bénévole"),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 133, 108, 108)),
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
