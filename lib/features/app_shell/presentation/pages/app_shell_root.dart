import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/core/di/injection_container.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/cubit/app_shell_cubit.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/pages/app_shell_page.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';

class AppShellRoot extends StatelessWidget {
  const AppShellRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppShellCubit>(
          create: (_) => sl<AppShellCubit>(),
        ),
        BlocProvider<PetsCubit>(
          create: (_) => sl<PetsCubit>()..load(),
        ),
      ],
      child: const AppShellPage(),
    );
  }
}
