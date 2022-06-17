import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Medicament extends StatefulWidget {
  const Medicament({Key? key}) : super(key: key);

  @override
  State<Medicament> createState() => _MedicamentState();
}

class _MedicamentState extends State<Medicament> {
  TextEditingController _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final CollectionReference _Medicament =
      FirebaseFirestore.instance.collection('Medicament');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'Ajouter';
    if (documentSnapshot != null) {
      action = 'Modifier';

      _contactController.text = documentSnapshot['contact'];
    }

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
                    controller: _contactController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'contact',
                    ),
                    validator: (val) {
                      if (val!.isEmpty ||
                          !RegExp(r'^[0-9]{8}$').hasMatch(val)) {
                        return "Enter Correct Phone Number";
                      }
                    },
                  ),
                  ElevatedButton(
                    child: Text(action == 'Ajouter' ? 'Ajouter' : 'Modifier'),
                    onPressed: () async {
                      final String? contact = _contactController.text;

                      if (_formKey.currentState!.validate()) {
                        if (action == 'Ajouter') {
                          // Persist a new product to Firestore
                          await _Medicament.add({
                            "contact": contact,
                          });
                        }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: const Text('Liste des donneurs '),
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
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['contact'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product

                          // This icon button is used to delete a single product
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
