import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class PaginatedPets extends Equatable {
  const PaginatedPets({
    required this.pets,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<PetEntity> pets;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  @override
  List<Object?> get props => [pets, total, page, limit, totalPages];
}
