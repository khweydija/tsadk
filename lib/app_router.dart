// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsdak/busines_logic/cubit/phone_auth_cubit.dart';
import 'package:tsdak/presentation/screens/hom_screen.dart';
import 'package:tsdak/presentation/screens/otp_screen.dart';
import 'Constnats/Strings.dart';
import 'presentation/screens/Login_Screen.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homScreen:
        return MaterialPageRoute(
          builder: (_) => HomScreen(),
        );

      case LoginScree:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final PhoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: PhoneNumber),
          ),
        );
    }
  }
}
