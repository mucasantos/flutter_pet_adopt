import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/cubit/app_shell_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/pages/pets_view.dart';
import 'package:flutter_pet_adopt/features/profile/presentation/pages/profile_page.dart';

import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_cubit.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_state.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/widgets/sdui_modal.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({
    super.key,
    this.pages,
  });

  final List<Widget>? pages;

  @override
  Widget build(BuildContext context) {
    final navigationPages = pages ??
        const [
          PetsView(),
          _ShellPlaceholder(
            title: 'Favorites',
            subtitle: 'Favorites flow is intentionally deferred.',
          ),
          _ShellPlaceholder(
            title: 'Add Pet',
            subtitle: 'Add-pet flow is intentionally deferred.',
          ),
          ProfilePage(),
        ];

    return BlocListener<CampaignCubit, CampaignState>(
      listener: (context, state) {
        if (state is CampaignLoaded) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => SduiCampaignModal(campaign: state.campaign),
          );
        }
      },
      child: BlocBuilder<AppShellCubit, int>(
        builder: (context, index) {
          return Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: index,
            children: navigationPages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            currentIndex: index,
            selectedItemColor: mainColor,
            unselectedItemColor: const Color.fromARGB(139, 255, 135, 171),
            selectedLabelStyle: const TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: mainColor,
            ),
            onTap: context.read<AppShellCubit>().changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_sharp),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    ),
  );
}
}

class _ShellPlaceholder extends StatelessWidget {
  const _ShellPlaceholder({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: mainColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
