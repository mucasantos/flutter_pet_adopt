import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/controller/pet_controller.dart';
import 'package:flutter_pet_adopt/controller/user_controller.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/view/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserController(),
    ),
    ChangeNotifierProvider(
      create: (_) => PetController(),
    ),
  ], child: const MyApp()));
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
