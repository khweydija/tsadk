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
          title: Text('Don de seng')
        ),
        
         
          

      
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'وَمَنْ أَحْيَاهَا فَكَأَنَّمَا أَحْيَا النَّاسَ جَمِيعًا',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 80),
              Text(
                'Si vous voulez donner votre sang cliquez ici ',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => Done()));
                },
                child: const Text('Donneur'),
              ),
              SizedBox(height: 30),
              Text('Si vous avez besoin de don de seng cliquez ici'),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('chercheur'),
              ),
            ],
          ),
        ));
  }
}
