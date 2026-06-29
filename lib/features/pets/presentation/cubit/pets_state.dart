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
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final PetsStatus status;
  final List<PetEntity> pets;
  final List<PetEntity> visiblePets;
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final String searchQuery;
  final String? message;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final bool isLoadingMore;

  PetsState copyWith({
    PetsStatus? status,
    List<PetEntity>? pets,
    List<PetEntity>? visiblePets,
    List<CategoryEntity>? categories,
    Object? selectedCategoryId = _sentinel,
    String? searchQuery,
    Object? message = _sentinel,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    bool? isLoadingMore,
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
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
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
        currentPage,
        totalPages,
        hasMore,
        isLoadingMore,
      ];
}

const _sentinel = Object();
