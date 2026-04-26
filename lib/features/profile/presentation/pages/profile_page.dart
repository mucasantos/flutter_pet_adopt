import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/core/presentation/widgets/app_button.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_pet_adopt/features/profile/presentation/widgets/profile_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final session = state.session;
        if (session == null) {
          return const Scaffold(
            body: Center(
              child: Text('Nenhum usuario autenticado.'),
            ),
          );
        }

        final user = session.user;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Column(
                  children: [
                    ProfileAvatar(
                      imageUrl: user.imageUrl,
                      radius: 52,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _ProfileInfoCard(
                title: 'Dados da conta',
                children: [
                  _ProfileInfoRow(label: 'ID', value: user.userId),
                  _ProfileInfoRow(label: 'Email', value: user.email),
                  _ProfileInfoRow(
                    label: 'Telefone',
                    value: user.phone ?? 'Nao informado',
                  ),
                  _ProfileInfoRow(
                    label: 'Perfil',
                    value: user.isAdmin == true ? 'Admin' : 'User',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _ProfileInfoCard(
                title: 'Sessao',
                children: [
                  _ProfileInfoRow(
                      label: 'Token', value: _maskToken(session.token)),
                ],
              ),
              const SizedBox(height: 24),
              AppButton(
                title: 'Logout',
                onPressed: context.read<AuthCubit>().logout,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  const _ProfileInfoCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: mainColor,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: mainColor,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

String _maskToken(String token) {
  if (token.length <= 10) {
    return token;
  }

  return '${token.substring(0, 6)}...${token.substring(token.length - 4)}';
}
