// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tsdak/CRUD/Donfamillies.dart';
import '../presentation/screens/don.dart';

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
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => bb(),
                    ),
                  );
                },
                child: const Text('Si  vous  êtes  un donateur , cliquez ici'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {},
                child: const Text('Si vous cherchez un donneur cliquez ici'),
              ),
            ],
          ),
        ));
  }
}
