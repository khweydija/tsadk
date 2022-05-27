// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsdak/Constnats/My_Colors.dart';
import 'package:tsdak/Constnats/Strings.dart';
import 'package:tsdak/busines_logic/cubit/phone_auth_cubit.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _phneFormKey = GlobalKey();

  late String phoneNumber;

  Widget _buildIntroTextes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quel est ton numéro de téléphone',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'Entrez votre numéro de téléphone',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneFormFied() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
                border: Border.all(color: MyColors.lightgrey),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Text(
              generateCountryFlag() + '+222',
              style: TextStyle(fontSize: 18, letterSpacing: 2.0),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(color: MyColors.blue),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: TextFormField(
              autofocus: true,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Entrez votre numéro de téléphone';
                } else if (value.length < 8) {
                  return 'Trop court pour un numéro de téléphone';
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'MR';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  Future<void> _register(BuildContext context) async {
    if (!_phneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _phneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          _register(context);
        },
        child: Text(
          'Next',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            maximumSize: Size(110, 50),
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
      ),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
        }
        if (state is ErrorOccured) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _phneFormKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroTextes(),
              SizedBox(
                height: 110,
              ),
              _buildPhoneFormFied(),
              SizedBox(
                height: 30,
              ),
              _buildNextButton(context),
              _buildPhoneNumberSubmitedBloc(),
            ],
          ),
        ),
      ),
    ));
  }
}
