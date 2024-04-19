import 'package:flutter/material.dart';

//const String serverAddress = 'petadopt.onrender.com';
const String serverAddress = 'rickandmortyapi.com';

const String logoImage = 'assets/images/logo.png';
const String faceImage = 'assets/images/facebook.png';
const String googleImage = 'assets/images/google.png';
const String userProfile = 'assets/images/userprofile.png';
const String iconSearch = 'assets/images/search_icon.png';
const String iconFilter = 'assets/images/filter_icon.png';
const String iconVertical = 'assets/images/icon_line.png';
const String dogImage = 'assets/images/dog1.png';
const String dogAnimaOne = 'assets/images/dog.gif';
const String dogAnimaTwo = 'assets/images/dog2.gif';

const Color mainColor = Color.fromARGB(255, 255, 135, 171);
const InputDecoration textFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(8),
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
const boxShadow = [
  BoxShadow(
    blurRadius: 8,
    color: Color(0x33000000),
    offset: Offset(0, 2),
    spreadRadius: 4,
  ),
];

//Para aula 01 signin

/*fonts*/
const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;
const textBackground = Color(0XFFE8E8E8);
const colorPrimary = Color(0XFFff8080);
const colorTest = Color(0xff2D165B);
