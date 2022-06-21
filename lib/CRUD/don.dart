// ignore_for_file: unused_local_variable, dead_code, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  String nom = '';
  String prenom = '';
  String? groupseng = 'A+';
  String contact = '';
  String age = '';
  TextEditingController Nom = TextEditingController();
  TextEditingController Prenom = TextEditingController();
  TextEditingController Contact = TextEditingController();
  TextEditingController Age = TextEditingController();
  bool _enProcessus = false;
  bool chargement = false;
  final CollectionReference _Don = FirebaseFirestore.instance.collection('Don');
  final _formKey = GlobalKey<FormState>();
  Position? position;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  enregistrerContact() async {
    setState(() => chargement = true);
    position = await _determinePosition();
      print("lat = ${position!.latitude} , long = ${position!.longitude}");
  await _Don.add({
        "nom": Nom.text,
        "prenom": Prenom.text,
        "groupseng": groupseng,
        "contact": Contact.text,
        "age": age,
        "lat": position!.latitude,
        "long": position!.longitude
      }).whenComplete(() {
        setState(() {
          Nom.clear();
          Prenom.clear();
          Contact.clear();
          Age.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Le donneur est ajouté avec succés"),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: Text('Nouveau Donneur'),
        actions: <Widget>[],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: Nom,
                      decoration: InputDecoration(
                          labelText: 'Nom ', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                          //allow upper and lower case alphabets and space
                          return "Entrer Correctement votre nom ";
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: Prenom,
                      decoration: InputDecoration(
                          labelText: 'prenom', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                          //allow upper and lower case alphabets and space
                          return "Entrer Correctement votre prénom";
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [Text("Choisir votre groupe sanguin")],
                    ),
                    DropdownButton(
                      value: groupseng,
                      items: [
                        DropdownMenuItem(
                          child: Text("A+"),
                          value: 'A+',
                        ),
                        DropdownMenuItem(
                          child: Text("A-"),
                          value: "A-",
                        ),
                        DropdownMenuItem(
                          child: Text("B+"),
                          value: "B+",
                        ),
                        DropdownMenuItem(
                          child: Text("B-"),
                          value: "B-",
                        ),
                        DropdownMenuItem(
                          child: Text("O+"),
                          value: "O+",
                        ),
                        DropdownMenuItem(
                          child: Text("O-"),
                          value: "O-",
                        ),
                        DropdownMenuItem(
                          child: Text("AB+"),
                          value: "AB+",
                        ),
                        DropdownMenuItem(
                          child: Text("AB-"),
                          value: "AB-",
                        )
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          groupseng = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: Contact,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Numero de tél',
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r'^[0-9]{8}$').hasMatch(val)) {
                          return "Entrer Correctement votre numero de télephone";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: Age,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          labelText: 'age', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.length < 2 || val.length > 2) {
                          return 'Entrer correctement votre  age';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => age = val,
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          enregistrerContact();
                        }
                      },
                      color: Color.fromARGB(255, 90, 148, 150),
                      height: 50,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text('Enregistrer',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
          (_enProcessus)
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.90,
                  child: Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
