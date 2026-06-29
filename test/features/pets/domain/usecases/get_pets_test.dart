import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_categories.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pets.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

import 'package:flutter_pet_adopt/features/pets/domain/entities/paginated_pets.dart';

class MockPetsRepository extends Mock implements PetsRepository {}

void main() {
  late MockPetsRepository repository;

  setUp(() {
    repository = MockPetsRepository();
  });

  test('GetPets returns pets from repository', () async {
    final usecase = GetPets(repository);
    const paginated = PaginatedPets(
      pets: samplePets,
      total: 2,
      page: 1,
      limit: 10,
      totalPages: 1,
    );
    when(() => repository.getPets(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) async => paginated);

    final result = await usecase(const GetPetsParams(page: 1, limit: 10));

    expect(result, paginated);
    verify(() => repository.getPets(page: 1, limit: 10)).called(1);
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
