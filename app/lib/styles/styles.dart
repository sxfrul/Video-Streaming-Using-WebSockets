import 'package:flutter/material.dart';

class Styles {
  static final buttonStyle =
      ElevatedButton.styleFrom(
        fixedSize: const Size(120.0, 10.0),
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        );

  static final buttonStyle2 = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    backgroundColor: Colors.black,
    minimumSize: const Size(200, 40),
  );

  static const textStyle = TextStyle(
      color: Colors.blue,
      fontFamily: 'Kalam',
      fontSize: 20,
      fontWeight: FontWeight.bold);
}
