import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class bb extends StatefulWidget {
  const bb({Key? key}) : super(key: key);

  @override
  State<bb> createState() => _bbState();
}

class _bbState extends State<bb> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final CollectionReference _familles =
      FirebaseFirestore.instance.collection('familles');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nomController.text = documentSnapshot['nom'];
      _prenomController.text = documentSnapshot['prenom'];
      _contactController.text = documentSnapshot['contact'].toString();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'nom'),
                ),
                TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'prenom'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'contact',
                  ),
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? nom = _nomController.text;
                    final String? prenom = _prenomController.text;

                    final double? contact =
                        double.tryParse(_contactController.text);

                    if (nom != null && prenom != null && contact != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _familles.add({
                          "nom": nom,
                          "prenom": prenom,
                          "contact": contact,
                        });
                      }
                      if (action == 'update') {
                        // Update the product
                        await _familles.doc(documentSnapshot!.id).update({
                          "nom": nom,
                          "prenom": prenom,
                          "contact": contact,
                        });
                      }

                      _nomController.text = '';
                      _prenomController.text = '';

                      _contactController.text = '';

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

  Future<void> _deleteProduct(String famillesId) async {
    await _familles.doc(famillesId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Vous avez supprimé la famille avec succès')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localisation des familles pauvre'),
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
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
