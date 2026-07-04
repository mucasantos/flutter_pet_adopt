import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/core/di/injection_container.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:flutter_pet_adopt/features/favorites/presentation/cubit/favorites_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>()..restoreSession(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => sl<FavoritesCubit>(),
        ),
      ],
      child: MaterialApp(
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
        home: const AuthGatePage(),
      ),
    );
  }
}
