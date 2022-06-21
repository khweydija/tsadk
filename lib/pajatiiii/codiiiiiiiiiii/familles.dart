// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tsdak/CRUD/Donfamillies.dart';
import 'package:tsdak/CRUD/Localisations.dart';
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
          centerTitle: true),
      body: Column(children: <Widget>[
        Image.asset('assets/images/yy.jpg'),
        SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text('Bienvenue',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: Text(
              'Si vous voulez localiser des femmes en besoin d aide Cliquez  sur  Bénévole ,si vous avez besoin d aide sociale cliquez sur chercheur',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: Row(children: <Widget>[
            Expanded(
                child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              color: Color.fromARGB(255, 109, 162, 172),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => bb()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'Bénévole',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Color.fromARGB(255, 107, 116, 117),
              onPressed: () {
                Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) => Localisation(don: false,)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'chercheur',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ))
          ]),
        ),
      ]),
    );
  }
}
