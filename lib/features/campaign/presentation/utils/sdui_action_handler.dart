import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/pages/pet_details_page.dart';
import 'package:flutter_pet_adopt/core/di/injection_container.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pet_by_id.dart';
import 'package:url_launcher/url_launcher.dart';

class SduiActionHandler {
  const SduiActionHandler(this.context);

  final BuildContext context;

  void execute(CampaignAction action) {
    final String type = action.type;
    final Map<String, dynamic> payload = action.payload;

    switch (type) {
      case 'NAVIGATE_INTERNAL':
        final String? route = payload['route'];
        final Map<String, dynamic>? arguments = payload['arguments'];
        if (route == '/adopt' && arguments != null) {
          final String? petId = arguments['petId']?.toString();
          if (petId != null) {
            try {
              final petsCubit = context.read<PetsCubit>();
              final pet = petsCubit.state.pets.firstWhere(
                (p) => p.id == petId,
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PetDetailsPage(pet: pet),
                ),
              );
            } catch (e) {
              debugPrint('⚠️ Pet com ID $petId não encontrado localmente. Buscando no servidor...');
              _fetchAndNavigate(petId);
            }
          }
        } else if (route != null) {
          Navigator.of(context).pushNamed(route, arguments: arguments);
        }
        break;

      case 'OPEN_EXTERNAL_URL':
        final String? urlString = payload['url'];
        if (urlString != null) {
          launchUrl(Uri.parse(urlString), mode: LaunchMode.externalApplication);
        }
        break;

      case 'CLOSE_MODAL':
        Navigator.of(context).pop();
        break;

      default:
        debugPrint('⚠️ Ação desconhecida no SDUI: $type');
    }
  }

  Future<void> _fetchAndNavigate(String petId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final getPetById = sl<GetPetById>();
      final pet = await getPetById(petId);

      // Pop the loading spinner safely
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Navigate to the Details Page safely
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PetDetailsPage(pet: pet),
          ),
        );
      }
    } catch (error) {
      // Pop the loading spinner safely
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show snackbar error safely
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar os detalhes do pet: $error'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
