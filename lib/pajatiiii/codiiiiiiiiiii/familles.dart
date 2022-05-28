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
          title: Text('Familles Indigentes'),
        ),
        backgroundColor: Color.fromARGB(255, 241, 241, 240),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'si vous voulez localiser des femmes en besoin d aide Cliquez ici'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => bb()));
                },
                child: const Text('Bénévole'),
              ),
              SizedBox(height: 30),
              Text('si vous avez besoin daide sociale cliquez ici'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('chercheur'),
              ),
            ],
          ),
        ));
  }
}
