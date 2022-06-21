// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsdak/CRUD/Medicament.dart';

import '../../CRUD/don.dart';
import '../codiiiiiiiiiii/pagetbr1.dart';

import '../codiiiiiiiiiii/familles.dart';
import 'app_data.dart';

class CategoryItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;

  CategoryItem(this.id, this.title, this.imageUrl);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  void selectDonedeseng(BuildContext ctx) {}
 /*
 late CameraPosition _cameraPosition;
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      print("lat = ${position!.latitude} , long = ${position.longitude}");
      await _Don.add({
        "nom": nom,
        "prenom": prenom,
        "groupseng": groupseng,
        "contact": contact,
        "age": age,
        "lat": position.latitude,
        "long": position.longitude
      }).then((value) {
        setState(() {
          Nom.clear();
          Prenom.clear();
          Contact.clear();
          Age.clear();
        });


  */
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (widget.id == 'C1')
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c) => MyStatefulWidget(),
              ),
            )
          }
        else
          {
            if (widget.id == 'C2')
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => Familles(),
                  ),
                )
              }
            else
              {
                if (widget.id == 'C3')
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => Medicament(),
                      ),
                    )
                  }
              }
          }
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              widget.imageUrl,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
          )
        ],
      ),
    );
  }
}
