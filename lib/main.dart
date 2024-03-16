import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
          color: mainColor,
          size: 30,
        )),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 150, 183)),
        useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
      ),
      home: const LoginScreen(),
    );
  }
}
