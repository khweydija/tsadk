// ignore_for_file: unused_local_variable, dead_code, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _groupsengController = TextEditingController();

  final CollectionReference _Don = FirebaseFirestore.instance.collection('Don');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nomController.text = documentSnapshot['nom'];
      _prenomController.text = documentSnapshot['prenom'];
      _groupsengController.text = documentSnapshot['groupseng'];
      _contactController.text = documentSnapshot['contact'].toString();
      _ageController.text = documentSnapshot['age'].toString();
    }
    String? selectedCity;
    List<String> citiesList = <String>[
      " A+",
      " A-",
      " B+",
      " B-",
      " O+",
      " O-",
      " AB+",
      " AB-",
    ];

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: ListView(
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'Prenom'),
                ),
                DropdownButton<String>(
                  hint: const Text(
                    'Group sangen',
                  ),
                  isExpanded: true,
                  value: selectedCity,
                  items: citiesList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (_) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    FocusScope.of(context).requestFocus(FocusNode());

                    setState(() {
                      selectedCity = _!;
                    });
                  },
                ),
                TextField(
                  controller: _groupsengController,
                  decoration: const InputDecoration(labelText: 'Group seng'),
                ),
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact',
                  ),
                  validator: (contact) {
                    if (contact == null || contact.isEmpty) {
                      return 'Entre vos contact';
                    }
                    if (contact.length < 8 || contact.length > 8) {
                      return 'Entrer correct contact00000';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? nom = _nomController.text;
                    final String? prenom = _prenomController.text;
                    final String? groupseng = selectedCity;
                    final double? contact =
                        double.tryParse(_contactController.text);
                    final double? age = double.tryParse(_ageController.text);

                    if (nom != null &&
                        prenom != null &&
                        groupseng != null &&
                        contact != null &&
                        age != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _Don.add({
                          "nom": nom,
                          "prenom": prenom,
                          "groupseng": groupseng,
                          "contact": contact,
                          "age": age
                        });
                      }
                      if (action == 'update') {
                        // Update the product
                        await _Don.doc(documentSnapshot!.id).update({
                          "nom": nom,
                          "prenom": prenom,
                          "groupseng": groupseng,
                          "contact": contact,
                          "age": age
                        });
                      }

                      _nomController.text = '';
                      _prenomController.text = '';
                      _groupsengController.text = '';
                      _contactController.text = '';
                      _ageController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Don de seng'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prenom'),
            ),
            TextField(
              controller: _groupsengController,
              decoration: const InputDecoration(labelText: 'Group seng'),
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Contact',
              ),
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Ajouter'),
              onPressed: () async {
                final String? nom = _nomController.text;
                final String? prenom = _prenomController.text;
                final String? groupseng = _groupsengController.text;
                final double? contact =
                    double.tryParse(_contactController.text);
                final double? age = double.tryParse(_ageController.text);

                if (nom != null &&
                    prenom != null &&
                    groupseng != null &&
                    contact != null &&
                    age != null) {
                  // Persist a new product to Firestore
                  await _Don.add({
                    "nom": nom,
                    "prenom": prenom,
                    "groupseng": groupseng,
                    "contact": contact,
                    "age": age
                  });

                  _nomController.text = '';
                  _prenomController.text = '';
                  _groupsengController.text = '';
                  _contactController.text = '';
                  _ageController.text = '';

                  // Hide the bottom sheet
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),

      // Add new product
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _createOrUpdate(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
