import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_state.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/pages/pets_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockPetsCubit extends MockCubit<PetsState> implements PetsCubit {}

void main() {
  late MockPetsCubit cubit;

  setUpAll(() {
    registerFallbackValue(const PetsState());
  });

  setUp(() {
    cubit = MockPetsCubit();
    when(() => cubit.selectCategory(any())).thenAnswer((_) {});
    when(() => cubit.updateSearch(any())).thenAnswer((_) {});
    when(() => cubit.retry()).thenAnswer((_) async {});
  });

  Future<void> pumpSubject(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PetsCubit>.value(
          value: cubit,
          child: const PetsView(),
        ),
      ),
    );
  }

  testWidgets('shows a loading indicator while loading', (tester) async {
    when(() => cubit.state)
        .thenReturn(const PetsState(status: PetsStatus.loading));
    whenListen(
      cubit,
      const Stream<PetsState>.empty(),
      initialState: const PetsState(status: PetsStatus.loading),
    );

    await pumpSubject(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows an error state and retries', (tester) async {
    const failureState = PetsState(
      status: PetsStatus.failure,
      message: 'Unable to load pets right now.',
    );

    when(() => cubit.state).thenReturn(failureState);
    whenListen(
      cubit,
      const Stream<PetsState>.empty(),
      initialState: failureState,
    );

    await pumpSubject(tester);

    expect(find.text('Unable to load pets right now.'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    verify(() => cubit.retry()).called(1);
  });

  testWidgets('shows an empty state when filters remove all pets',
      (tester) async {
    const emptyState = PetsState(
      status: PetsStatus.success,
      categories: sampleCategories,
    );

    when(() => cubit.state).thenReturn(emptyState);
    whenListen(
      cubit,
      const Stream<PetsState>.empty(),
      initialState: emptyState,
    );

    await pumpSubject(tester);

    expect(
      find.text('No pets matched the current search or category filters.'),
      findsOneWidget,
    );
  });

  testWidgets('shows pets, selects a category, and navigates to details',
      (tester) async {
    const successState = PetsState(
      status: PetsStatus.success,
      pets: samplePets,
      visiblePets: samplePets,
      categories: sampleCategories,
    );

    when(() => cubit.state).thenReturn(successState);
    whenListen(
      cubit,
      const Stream<PetsState>.empty(),
      initialState: successState,
    );

    await pumpSubject(tester);

    expect(find.text('Milo'), findsOneWidget);
    expect(find.text('Buddy'), findsOneWidget);

    await tester.tap(find.text('CAT'));
    verify(() => cubit.selectCategory('cat')).called(1);

    await tester.tap(find.text('Milo').first);
    await tester.pumpAndSettle();

    expect(find.text('My Story'), findsOneWidget);
    expect(find.text('Friendly cat that loves naps.'), findsOneWidget);
  });
}
