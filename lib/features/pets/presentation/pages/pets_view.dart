import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_state.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/pages/pet_details_page.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/category_chip.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/empty_pets_states.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pet_card.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pets_error_states.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pets_header.dart';
import 'package:flutter_pet_adopt/features/profile/presentation/widgets/profile_avatar.dart';

class PetsView extends StatefulWidget {
  const PetsView({super.key});

  @override
  State<PetsView> createState() => _PetsViewState();
}

class _PetsViewState extends State<PetsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PetsCubit>().loadNextPage();
    }
  }

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
          padding: const EdgeInsets.only(left: 12),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return ProfileAvatar(
                imageUrl: state.session?.user.imageUrl,
                radius: 20,
              );
            },
          ),
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

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pet = state.visiblePets[index];
                      return PetCard(
                        pet: pet,
                        onTap: () => _openDetails(context, pet),
                      );
                    },
                    childCount: state.visiblePets.length,
                  ),
                ),
              ),
              if (state.isLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
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
