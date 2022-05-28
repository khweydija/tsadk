// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
          title: Text('Familles Indigentes'),
        ),
        backgroundColor: Color.fromARGB(255, 241, 241, 240),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('وَمَنْ أَحْيَاهَا فَكَأَنَّمَا أَحْيَا النَّاسَ جَمِيعًا'),
              SizedBox(height: 50),
              Text('Si vous êtes un donateur, cliquez ici'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => Done()));
                },
                child: const Text('Donneur'),
              ),
              SizedBox(height: 30),
              Text('Si vous cherchez un donneur cliquez ici'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('chercheur'),
              ),
            ],
          ),
        ));
  }
}
