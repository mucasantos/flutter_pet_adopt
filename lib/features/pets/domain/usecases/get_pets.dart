import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/paginated_pets.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';

class GetPets implements UseCase<PaginatedPets, GetPetsParams> {
  const GetPets(this.repository);

  final PetsRepository repository;

  @override
  Future<PaginatedPets> call(GetPetsParams params) {
    return repository.getPets(page: params.page, limit: params.limit);
  }
}

class GetPetsParams extends Equatable {
  const GetPetsParams({
    required this.page,
    required this.limit,
  });

  final int page;
  final int limit;

  @override
  List<Object?> get props => [page, limit];
}
