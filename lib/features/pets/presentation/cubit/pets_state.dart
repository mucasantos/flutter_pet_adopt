import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

enum PetsStatus { initial, loading, success, failure }

class PetsState extends Equatable {
  const PetsState({
    this.status = PetsStatus.initial,
    this.pets = const [],
    this.visiblePets = const [],
    this.categories = const [],
    this.selectedCategoryId,
    this.searchQuery = '',
    this.message,
  });

  final PetsStatus status;
  final List<PetEntity> pets;
  final List<PetEntity> visiblePets;
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final String searchQuery;
  final String? message;

  PetsState copyWith({
    PetsStatus? status,
    List<PetEntity>? pets,
    List<PetEntity>? visiblePets,
    List<CategoryEntity>? categories,
    Object? selectedCategoryId = _sentinel,
    String? searchQuery,
    Object? message = _sentinel,
  }) {
    return PetsState(
      status: status ?? this.status,
      pets: pets ?? this.pets,
      visiblePets: visiblePets ?? this.visiblePets,
      categories: categories ?? this.categories,
      selectedCategoryId: identical(selectedCategoryId, _sentinel)
          ? this.selectedCategoryId
          : selectedCategoryId as String?,
      searchQuery: searchQuery ?? this.searchQuery,
      message:
          identical(message, _sentinel) ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => [
        status,
        pets,
        visiblePets,
        categories,
        selectedCategoryId,
        searchQuery,
        message,
      ];
}

const _sentinel = Object();
