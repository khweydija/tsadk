// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tsdak/CRUD/Medicament.dart';

import '../../CRUD/don.dart';
import '../codiiiiiiiiiii/pagetbr1.dart';

import '../codiiiiiiiiiii/familles.dart';
import 'app_data.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  CategoryItem(this.id, this.title, this.imageUrl);

  void selectDonedeseng(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (id == 'C1')
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c) =>MyStatefulWidget(),
              ),
            )
          }
        else
          {
            if (id == 'C2')
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => Familles(),
                  ),
                )
              }
            else
              {
                if (id == 'C3')
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
              imageUrl,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              title,
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
