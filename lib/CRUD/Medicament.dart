// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Medicament extends StatefulWidget {
  const Medicament({Key? key}) : super(key: key);

  @override
  State<Medicament> createState() => _MedicamentState();
}

class _MedicamentState extends State<Medicament> {
  late File _imagefile;
  bool _islog = false;
  PlatformFile? pickedfile;
  File? file;
  late final urlDownload;
  UploadTask? uploadTask;
  TextEditingController _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final CollectionReference _Medicament =
      FirebaseFirestore.instance.collection('Medicament');

  String img = "";

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'Ajouter';
    if (documentSnapshot != null) {
      action = 'Modifier';

      _contactController.text = documentSnapshot['contact'];
      img = documentSnapshot['image'];
    }
    setState(() {
      showModalBottomSheet(
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
                      controller: _contactController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'contact',
                      ),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r'^[0-9]{8}$').hasMatch(val)) {
                          return "Entrer corretement votre contact";
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: () {
                            selectFile();
                            // Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.camera),
                          label: Text("Camera"),
                        ),
                      ],
                    ),
                    isLoding == false
                        ? ElevatedButton(
                            child: Text(
                                action == 'Ajouter' ? 'Ajouter' : 'Modifier'),
                            onPressed: () async {
                              // final String? contact = _contactController.text;

                              if (_formKey.currentState!.validate()) {
                                if (action == 'Ajouter') {
                                  // Persist a new product to Firestore
                                  uploadFile();
                                }

                                // _contactController.clear();

                                // Hide the bottom sheet
                                Navigator.of(context).pop();
                              }
                            },
                          )
                        : CircularProgressIndicator()
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: const Text('Liste des médicaments  '),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _Medicament.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      leading: Image.network(
                        documentSnapshot['image'].toString(),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                      title: Text(documentSnapshot['contact'].toString()),
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

  PlatformFile? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  bool isLoding = false;
  Future uploadFile() async {
    setState(() {
      isLoding = false;
    });
    final path = "Service/${pickedFile!.name}";
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final _Medicament_image = await snapshot.ref.getDownloadURL();
    await _Medicament.add(
            {"contact": _contactController.text, "image": _Medicament_image})
        .whenComplete(() {
      setState(() {
        isLoding = false;
      });
      _contactController.clear();
    });
  }
}
