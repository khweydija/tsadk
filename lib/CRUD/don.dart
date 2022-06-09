// ignore_for_file: unused_local_variable, dead_code, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  String nom = '';
  String prenom = '';
  String? groupseng = 'A+';
  String contact = '';
  String age = '';

  bool _enProcessus = false;
  bool chargement = false;
  final CollectionReference _Don = FirebaseFirestore.instance.collection('Don');
  final _formKey = GlobalKey<FormState>();
  enregistrerContact() async {
    setState(() => chargement = true);

    await _Don.add({
      "nom": nom,
      "prenom": prenom,
      "groupseng": groupseng,
      "contact": contact,
      "age": age
    });
    this.setState(() {
      Navigator.pop(context);
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
                      decoration: InputDecoration(
                          labelText: 'Nom ', border: OutlineInputBorder()),
                      validator: (val) => val!.isEmpty ? 'Entrez un nom' : null,
                      onChanged: (val) => nom = val,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'prenom', border: OutlineInputBorder()),
                      validator: (val) =>
                          val!.isEmpty ? 'Entrez votre prenom' : null,
                      onChanged: (val) => prenom = val,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [Text("Choisir votre group sanguin")],
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
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Numero de tél',
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.length < 8 || val.length > 8) {
                          return 'Entrer correct numero';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => contact = val,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          labelText: 'age', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.length < 2 || val.length > 2) {
                          return 'Entrer correct age';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => age = val,
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          enregistrerContact();
                        }
                      },
                      color: Color.fromARGB(255, 90, 148, 150),
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
