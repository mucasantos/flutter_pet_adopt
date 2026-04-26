import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_categories.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pets.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockPetsRepository extends Mock implements PetsRepository {}

void main() {
  late MockPetsRepository repository;

  setUp(() {
    repository = MockPetsRepository();
  });

  test('GetPets returns pets from repository', () async {
    final usecase = GetPets(repository);
    when(() => repository.getPets()).thenAnswer((_) async => samplePets);

    final result = await usecase(const NoParams());

    expect(result, samplePets);
    verify(() => repository.getPets()).called(1);
  });

  test('GetCategories returns categories from repository', () async {
    final usecase = GetCategories(repository);
    when(() => repository.getCategories())
        .thenAnswer((_) async => sampleCategories);

    final result = await usecase(const NoParams());

    expect(result, sampleCategories);
    verify(() => repository.getCategories()).called(1);
  });
}
