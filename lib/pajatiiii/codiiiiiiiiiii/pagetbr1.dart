// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tsdak/CRUD/Donfamillies.dart';
import 'package:tsdak/CRUD/Localisations.dart';
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
       
      body: Container(
        color: Colors.black,
        child: Stack(children: [
          Positioned.fill(
              child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    'assets/images/zz.jpg',
                    fit: BoxFit.cover,
                  ))),
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'وَمَنْ أَحْيَاهَا فَكَأَنَّمَا أَحْيَا النَّاسَ   جَمِيعاً',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Text(
                      'Si vous voulez donner votre sang cliquez sur Donneur ,Si vous avez besoin de don de seng cliquez sur chercheur',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (c) => Done()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(400)),
                      color: Color.fromARGB(248, 20, 98, 117),
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Donneur',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            SizedBox(height: 10),

                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) => Localisation()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(400)),
                          color: Color.fromARGB(255, 75, 116, 112),

                          //color: Color.fromARGB(248, 20, 98, 117),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'chercheur',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),

                  //         // )))
                ]),
          )
        ]),
      ),
    );
  }
}
