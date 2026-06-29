import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';

class GetPetById implements UseCase<PetEntity, String> {
  const GetPetById(this.repository);

  final PetsRepository repository;

  @override
  Future<PetEntity> call(String id) async {
    return repository.getPetById(id);
  }
}
