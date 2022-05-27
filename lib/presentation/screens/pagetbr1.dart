// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'don.dart';

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
                      builder: (c) => Done(),
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
