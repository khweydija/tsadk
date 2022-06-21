import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsdak/models/Don.dart';

class Localisation extends StatefulWidget {
  final bool don;
  const Localisation({Key? key, required this.don}) : super(key: key);

  @override
  State<Localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<Localisation> {
  // ignore: prefer_const_constructors
  final CameraPosition _cameraPosition =
      CameraPosition(
        target: LatLng(18.15, -15.95), zoom: 10);
  final Completer<GoogleMapController> _controller = Completer();
  late final List<Marker> _markers = [];
  getDon() {
    return FirebaseFirestore.instance.collection("Don").get().then((value) {
      for (var mark in value.docs) {
        Marker marker = Marker(
            markerId: MarkerId(mark['nom']),
            position: LatLng(mark['lat'], mark['long']),
            infoWindow: InfoWindow(title: mark['nom']));
        setState(() {
          _markers.add(marker);
        });
      }
    });
  }

  getFam() {
    return FirebaseFirestore.instance
        .collection("familles")
        .get()
        .then((value) {
      for (var mark in value.docs) {
        Marker marker = Marker(
            markerId: MarkerId(mark['nom']),
            position: LatLng(mark['lat'], mark['long']),
            infoWindow: InfoWindow(title: mark['nom']));
        setState(() {
          _markers.add(marker);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.don) {
      getDon();
    } else {
      getFam();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 88, 133, 145),
            title: Text(widget.don == true? "Localisation des donneurs" : "Localisation des familles", style: TextStyle(color: Colors.white)),
            centerTitle: true),
        body: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          initialCameraPosition: _cameraPosition,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ));
  }
}
