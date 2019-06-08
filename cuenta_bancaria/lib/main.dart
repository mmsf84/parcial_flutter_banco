import 'package:flutter/material.dart';
import 'package:cuenta_bancaria/screens/home_ctabanca.dart';
import 'package:cuenta_bancaria/app_constants.dart';

const PrimaryColor = const Color(0xFF06006D);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      fontFamily: "Roboto",
      primaryColor: AppConstants.primaryColor,
    );
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: HomeCtaBanca(),
    );
  }
}
