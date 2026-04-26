import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';

class GetPets implements UseCase<List<PetEntity>, NoParams> {
  const GetPets(this.repository);

  final PetsRepository repository;

  @override
  Future<List<PetEntity>> call(NoParams params) {
    return repository.getPets();
  }
}
