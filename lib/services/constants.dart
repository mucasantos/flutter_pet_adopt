import 'package:flutter/material.dart';

const String logoImage = 'assets/images/logo.png';
const String faceImage = 'assets/images/facebook.png';
const String googleImage = 'assets/images/google.png';
const Color mainColor = Color.fromARGB(255, 255, 135, 171);
const InputDecoration textFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(
      color: Color.fromARGB(255, 255, 135, 171),
      width: 1,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: Color.fromARGB(255, 255, 135, 171), width: 1),
  ),
  filled: true,
  fillColor: Color.fromARGB(26, 255, 135, 171),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);
const TextStyle titleStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
const TextStyle titleStyleOr =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
