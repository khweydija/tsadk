// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class bb extends StatefulWidget {
  const bb({Key? key}) : super(key: key);

  @override
  State<bb> createState() => _bbState();
}

class _bbState extends State<bb> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final CollectionReference _familles =
      FirebaseFirestore.instance.collection('familles');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'Ajouter';
    if (documentSnapshot != null) {
      action = 'Modifier';
      _nomController.text = documentSnapshot['nom'];
      _prenomController.text = documentSnapshot['prenom'];
      _contactController.text = documentSnapshot['contact'];
    }

    Position? position;
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nomController,
                    decoration: const InputDecoration(labelText: 'nom'),
                    validator: (val) {
                      if (val!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                        //allow upper and lower case alphabets and space
                        return "Entrer Correctement votre nom";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _prenomController,
                    decoration: const InputDecoration(labelText: 'prenom'),
                    validator: (val) {
                      if (val!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                        //allow upper and lower case alphabets and space
                        return "Entrer Correctement votre prénom ";
                      }
                    },
                    onChanged: (val) {
                      _prenomController:
                      val;
                    },
                  ),
                  TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'contact',
                    ),
                    validator: (val) {
                      if (val!.isEmpty ||
                          !RegExp(r'^[0-9]{8}$').hasMatch(val)) {
                        return "Entrer Correct votre contact";
                      }
                    },
                  ),
                  ElevatedButton(
                    child: Text(action == 'Ajouter' ? 'Ajouter' : 'Modifier'),
                    onPressed: () async {
                      final String? nom = _nomController.text;
                      final String? prenom = _prenomController.text;

                      final String? contact = _contactController.text;

                      if (_formKey.currentState!.validate()) {
                        if (action == 'Ajouter') {
                          position = await _determinePosition();
                          // Persist a new product to Firestore
                          await _familles.add({
                            "nom": nom,
                            "prenom": prenom,
                            "contact": contact,
                            "lat": position!.latitude,
                            "long": position!.longitude,
                          });
                        }
                        if (action == 'Modifier') {
                          // Update the product
                          await _familles.doc(documentSnapshot!.id).update({
                            "nom": nom,
                            "prenom": prenom,
                            "contact": contact,
                            "lat": position!.latitude,
                            "long": position!.longitude,
                          });
                        }

                        _nomController.clear();
                        _prenomController.clear();

                        _contactController.clear();

                        // Hide the bottom sheet
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _deleteProduct(String famillesId) async {
    await _familles.doc(famillesId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Vous avez supprimé la famille avec succés')));
  }

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

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: const Text('Liste des familles pauvres'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _familles.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['nom']),
                    subtitle: Text(documentSnapshot['contact'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Color.fromARGB(255, 33, 151, 145),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Expanded(
                                    child: AlertDialog(
                                      title: Text(
                                          'Voulez-vous vraiment supprimer?'),
                                      content: Text('Supprimer'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            _deleteProduct(documentSnapshot.id);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Oui',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Non',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 3, 70, 66),
        ),
      ),
    );
  }
}
