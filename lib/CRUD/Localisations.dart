import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsdak/models/Don.dart';

class Localisation extends StatefulWidget {
  const Localisation({Key? key}) : super(key: key);

  @override
  State<Localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<Localisation> {
  // ignore: prefer_const_constructors
  final CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(18, -15), zoom: 1);
  final Completer<GoogleMapController> _controller = Completer();
  late final List<Marker> _markers = [];

  getDon() {
    return FirebaseFirestore.instance.collection("Don").get().then((value) {
    for (var mark in value.docs) {
      Marker marker = Marker(
          markerId: MarkerId(mark['nom']),
          position: LatLng(mark['lat'],mark['long']),
          infoWindow: InfoWindow(title: mark['nom']));
      setState(() {
        _markers.add(marker);
      });
    }
    });
    // });
  }

  @override
  void initState() {
    super.initState();
    getDon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 88, 133, 145),
            title: Text("Localisation", style: TextStyle(color: Colors.white)),
            centerTitle: true),
        body: GoogleMap(
          initialCameraPosition: _cameraPosition,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )
        );
  }
}
