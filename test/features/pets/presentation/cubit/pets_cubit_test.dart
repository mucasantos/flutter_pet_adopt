import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_categories.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pets.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockGetPets extends Mock implements GetPets {}

class MockGetCategories extends Mock implements GetCategories {}

void main() {
  late MockGetPets getPets;
  late MockGetCategories getCategories;

  setUpAll(() {
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    getPets = MockGetPets();
    getCategories = MockGetCategories();
  });

  PetsCubit buildCubit() {
    return PetsCubit(
      getPets: getPets,
      getCategories: getCategories,
    );
  }

  blocTest<PetsCubit, PetsState>(
    'emits loading then success when data loads',
    build: () {
      when(() => getPets(any())).thenAnswer((_) async => samplePets);
      when(() => getCategories(any()))
          .thenAnswer((_) async => sampleCategories);
      return buildCubit();
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const PetsState(status: PetsStatus.loading),
      const PetsState(
        status: PetsStatus.success,
        pets: samplePets,
        visiblePets: samplePets,
        categories: sampleCategories,
      ),
    ],
  );

  blocTest<PetsCubit, PetsState>(
    'emits loading then failure when pets fail to load',
    build: () {
      when(() => getPets(any())).thenThrow(
        const FailureException(ServerFailure('Unable to load pets')),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const PetsState(status: PetsStatus.loading),
      const PetsState(
        status: PetsStatus.failure,
        message: 'Unable to load pets',
      ),
    ],
  );

  blocTest<PetsCubit, PetsState>(
    'filters pets by selected category',
    build: () {
      when(() => getPets(any())).thenAnswer((_) async => samplePets);
      when(() => getCategories(any()))
          .thenAnswer((_) async => sampleCategories);
      return buildCubit();
    },
    act: (cubit) async {
      await cubit.load();
      cubit.selectCategory('cat');
    },
    expect: () => [
      const PetsState(status: PetsStatus.loading),
      const PetsState(
        status: PetsStatus.success,
        pets: samplePets,
        visiblePets: samplePets,
        categories: sampleCategories,
      ),
      const PetsState(
        status: PetsStatus.success,
        pets: samplePets,
        visiblePets: [samplePet],
        categories: sampleCategories,
        selectedCategoryId: 'cat',
      ),
    ],
  );

  blocTest<PetsCubit, PetsState>(
    'filters pets by search query',
    build: () {
      when(() => getPets(any())).thenAnswer((_) async => samplePets);
      when(() => getCategories(any()))
          .thenAnswer((_) async => sampleCategories);
      return buildCubit();
    },
    act: (cubit) async {
      await cubit.load();
      cubit.updateSearch('buddy');
    },
    expect: () => [
      const PetsState(status: PetsStatus.loading),
      const PetsState(
        status: PetsStatus.success,
        pets: samplePets,
        visiblePets: samplePets,
        categories: sampleCategories,
      ),
      const PetsState(
        status: PetsStatus.success,
        pets: samplePets,
        visiblePets: [sampleDogPet],
        categories: sampleCategories,
        searchQuery: 'buddy',
      ),
    ],
  );

  blocTest<PetsCubit, PetsState>(
    'retries loading after an initial failure',
    build: () {
      var attempts = 0;
      when(() => getPets(any())).thenAnswer((_) async {
        if (attempts == 0) {
          attempts += 1;
          throw const FailureException(ServerFailure('Temporary failure'));
        }
        return samplePets;
      });
      when(() => getCategories(any()))
          .thenAnswer((_) async => sampleCategories);
      return buildCubit();
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.retry();
    },
    expect: () => [
      const PetsState(status: PetsStatus.loading),
      const PetsState(
        status: PetsStatus.failure,
        message: 'Temporary failure',
      ),
      const PetsState(
        status: PetsStatus.loading,
        message: null,
      ),
      const PetsState(
        status: PetsStatus.success,
        pets: samplePets,
        visiblePets: samplePets,
        categories: sampleCategories,
      ),
    ],
  );
}
