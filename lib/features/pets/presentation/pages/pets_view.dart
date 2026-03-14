import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_state.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/pages/pet_details_page.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/category_chip.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/empty_pets_states.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pet_card.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pets_error_states.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pets_header.dart';

class PetsView extends StatelessWidget {
  const PetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossAxisCount = screenWidth > 900
        ? 4
        : screenWidth > 600
            ? 3
            : 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(userProfile),
        ),
        title: const PetsHeader(),
        actions: const [
          IconButton(
            onPressed: _noop,
            icon: Icon(Icons.notifications_none, size: 30),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                TextField(
                  onChanged: context.read<PetsCubit>().updateSearch,
                  decoration: const InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _noop,
                      icon: Icon(Icons.search),
                    ),
                    labelText: 'Search',
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 175, 175, 175),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 175, 175, 175),
                        width: 1,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF8F8F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<PetsCubit, PetsState>(
                  buildWhen: (previous, current) {
                    return previous.categories != current.categories ||
                        previous.selectedCategoryId !=
                            current.selectedCategoryId;
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryChip(
                            label: 'All',
                            selected: state.selectedCategoryId == null,
                            onSelected: (_) {
                              context.read<PetsCubit>().selectCategory(null);
                            },
                          ),
                          ...state.categories.map((category) {
                            return CategoryChip(
                              label: category.name,
                              imageUrl: category.imageUrl,
                              selected: state.selectedCategoryId == category.id,
                              onSelected: (selected) {
                                context.read<PetsCubit>().selectCategory(
                                      selected ? category.id : null,
                                    );
                              },
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<PetsCubit, PetsState>(
        listenWhen: (previous, current) {
          return previous.status != current.status &&
              current.status == PetsStatus.failure &&
              current.message != null;
        },
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        },
        builder: (context, state) {
          if (state.status == PetsStatus.loading && state.pets.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PetsStatus.failure && state.pets.isEmpty) {
            return PetsErrorState(
              message: state.message ?? 'Unable to load pets right now.',
              onRetry: context.read<PetsCubit>().retry,
            );
          }

          if (state.visiblePets.isEmpty) {
            return const EmptyPetsState();
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: state.visiblePets.length,
            itemBuilder: (context, index) {
              final pet = state.visiblePets[index];
              return PetCard(
                pet: pet,
                onTap: () => _openDetails(context, pet),
              );
            },
          );
        },
      ),
    );
  }

  void _openDetails(BuildContext context, PetEntity pet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PetDetailsPage(pet: pet),
      ),
    );
  }
}

void _noop() {}
