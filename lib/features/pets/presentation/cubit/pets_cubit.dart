import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_categories.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pets.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_state.dart';

class PetsCubit extends Cubit<PetsState> {
  PetsCubit({
    required GetPets getPets,
    required GetCategories getCategories,
  })  : _getPets = getPets,
        _getCategories = getCategories,
        super(const PetsState());

  final GetPets _getPets;
  final GetCategories _getCategories;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: PetsStatus.loading,
        message: null,
      ),
    );

    try {
      final pets = await _getPets(const NoParams());
      final categories = await _getCategories(const NoParams());

      emit(
        _buildFilteredState(
          pets: pets,
          categories: categories,
          status: PetsStatus.success,
          message: null,
        ),
      );
    } on FailureException catch (error) {
      emit(
        state.copyWith(
          status: PetsStatus.failure,
          message: error.failure.message,
          pets: const [],
          visiblePets: const [],
          categories: const [],
          selectedCategoryId: null,
          searchQuery: '',
        ),
      );
    }
  }

  Future<void> retry() => load();

  void selectCategory(String? categoryId) {
    emit(
      _buildFilteredState(
        selectedCategoryId: categoryId,
        status: PetsStatus.success,
      ),
    );
  }

  void updateSearch(String query) {
    emit(
      _buildFilteredState(
        searchQuery: query,
        status: PetsStatus.success,
      ),
    );
  }

  PetsState _buildFilteredState({
    List<PetEntity>? pets,
    List<CategoryEntity>? categories,
    Object? selectedCategoryId = _categorySentinel,
    String? searchQuery,
    PetsStatus? status,
    Object? message = _messageSentinel,
  }) {
    final resolvedPets = pets ?? state.pets;
    final resolvedCategories = categories ?? state.categories;
    final resolvedSelectedCategoryId =
        identical(selectedCategoryId, _categorySentinel)
            ? state.selectedCategoryId
            : selectedCategoryId as String?;
    final resolvedSearchQuery = searchQuery ?? state.searchQuery;

    final visiblePets = resolvedPets.where((pet) {
      return _matchesCategory(
            pet,
            resolvedSelectedCategoryId,
            resolvedCategories,
          ) &&
          _matchesSearch(pet, resolvedSearchQuery);
    }).toList(growable: false);

    return state.copyWith(
      status: status ?? state.status,
      pets: resolvedPets,
      visiblePets: visiblePets,
      categories: resolvedCategories,
      selectedCategoryId: resolvedSelectedCategoryId,
      searchQuery: resolvedSearchQuery,
      message: message,
    );
  }

  bool _matchesCategory(
    PetEntity pet,
    String? selectedCategoryId,
    List<CategoryEntity> categories,
  ) {
    if (selectedCategoryId == null) {
      return true;
    }

    if (pet.categoryId != null && pet.categoryId == selectedCategoryId) {
      return true;
    }

    final selectedCategory = categories.where((category) {
      return category.id == selectedCategoryId;
    });

    if (selectedCategory.isEmpty) {
      return true;
    }

    final selectedName = selectedCategory.first.name.toLowerCase();
    final petCategoryName = pet.categoryName?.toLowerCase();

    if (petCategoryName == null) {
      return true;
    }

    return petCategoryName == selectedName;
  }

  bool _matchesSearch(PetEntity pet, String query) {
    if (query.trim().isEmpty) {
      return true;
    }

    final normalizedQuery = query.trim().toLowerCase();
    final searchableFields = [
      pet.name,
      pet.breed,
      pet.color,
      pet.story,
      pet.categoryName,
    ];

    return searchableFields.any((field) {
      return field?.toLowerCase().contains(normalizedQuery) ?? false;
    });
  }
}

const _categorySentinel = Object();
const _messageSentinel = Object();
