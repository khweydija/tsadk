import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Medicament extends StatefulWidget {
  const Medicament({Key? key}) : super(key: key);

  @override
  State<Medicament> createState() => _MedicamentState();
}

class _MedicamentState extends State<Medicament> {
  final TextEditingController _contactController = TextEditingController();

  final CollectionReference _Medicament =
      FirebaseFirestore.instance.collection('Medicament');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';

      _contactController.text = documentSnapshot['contact'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'contact',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final double? contact =
                        double.tryParse(_contactController.text);
                    if (contact != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _Medicament.add({"contact": contact});
                      }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Don des médicaments'),
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
                      child: Row(children: [
                        // Press this button to edit a single product

                        // This icon button is used to delete a single product
                      ]),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
