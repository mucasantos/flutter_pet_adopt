import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/core/di/injection_container.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/pages/app_shell_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adopt Me',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: mainColor,
            size: 30,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 58, 150, 183),
        ),
        useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
      ),
      home: const AppShellRoot(),
    );
  }
}
