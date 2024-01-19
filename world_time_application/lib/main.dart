import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'Pages/ChoiceLocation.dart';
import 'Pages/Loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes:{
      '/':(context) => const Loading(),
      '/home':(context) => const HOME(),
      '/location':(context) => const ChooseLocation(),
    },
    ));
}
