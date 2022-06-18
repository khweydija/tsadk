// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsdak/Constnats/Strings.dart';
import 'package:tsdak/busines_logic/cubit/phone_auth_cubit.dart';
import 'package:tsdak/pajatiiii/widgetss/category_item.dart';
import 'package:tsdak/pajatiiii/models/category.dart';
import 'package:tsdak/pajatiiii/widgetss/app_data.dart';
import 'package:tsdak/pajatiiii/widgetss/category_item.dart';

import '../../pajatiiii/widgetss/app_data.dart';
import 'Login_Screen.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 133, 145),
        title: Row(
          children: [
            Icon(Icons.water_damage),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(" Page d'acceueil "),
            ),
            SizedBox(
              width: 120,
            ),
            //IconButton(
            //  onPressed: () async {
            //   await FirebaseAuth.instance.signOut();
            //   Navigator.of(context).pushReplacementNamed(LoginScreen());
            // },
            // icon: Icon(Icons.logout),
            // )
          ],
        ),
      ),
      body: GridView(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 5 / 8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        children: Category_data.map(
          (CategoryData) => CategoryItem(
              CategoryData.id, CategoryData.title, CategoryData.imageUrl),
        ).toList(),
      ),
    );
  }
}
