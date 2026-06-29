import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/pets/data/datasources/pets_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/pets/data/repositories/pets_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockPetsRemoteDataSource extends Mock implements PetsRemoteDataSource {}

void main() {
  late MockPetsRemoteDataSource remoteDataSource;
  late PetsRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockPetsRemoteDataSource();
    repository = PetsRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  test('maps pet models into pet entities', () async {
    const paginatedModel = PaginatedPetsModel(
      pets: [
        samplePetModel,
        sampleDogPetModel,
      ],
      total: 2,
      page: 1,
      limit: 10,
      totalPages: 1,
    );
    when(() => remoteDataSource.getPets(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) async => paginatedModel);

    final result = await repository.getPets(page: 1, limit: 10);

    expect(result.pets, samplePets);
    expect(result.total, 2);
    verify(() => remoteDataSource.getPets(page: 1, limit: 10)).called(1);
  });

  test('translates server exceptions into failure exceptions', () async {
    when(() => remoteDataSource.getPets(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        )).thenThrow(
      const ServerException(message: 'Server unavailable'),
    );

    expect(
      repository.getPets(page: 1, limit: 10),
      throwsA(
        isA<FailureException>().having(
          (error) => error.failure,
          'failure',
          const ServerFailure('Server unavailable'),
        ),
      ),
    );
  });

  test('translates parsing exceptions into failure exceptions', () async {
    when(() => remoteDataSource.getCategories()).thenThrow(
      const ParsingException(message: 'Invalid categories payload'),
    );

    expect(
      repository.getCategories(),
      throwsA(
        isA<FailureException>().having(
          (error) => error.failure,
          'failure',
          const ParsingFailure('Invalid categories payload'),
        ),
      ),
    );
  });
}
