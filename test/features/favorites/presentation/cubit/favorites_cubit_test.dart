import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/add_favorite.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/get_favorites.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:flutter_pet_adopt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter_pet_adopt/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockGetFavorites extends Mock implements GetFavorites {}
class MockAddFavorite extends Mock implements AddFavorite {}
class MockRemoveFavorite extends Mock implements RemoveFavorite {}
class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late MockGetFavorites getFavorites;
  late MockAddFavorite addFavorite;
  late MockRemoveFavorite removeFavorite;
  late MockAuthCubit authCubit;

  setUpAll(() {
    registerFallbackValue(const FavoriteParams(token: 'token', petId: 'pet'));
  });

  setUp(() {
    getFavorites = MockGetFavorites();
    addFavorite = MockAddFavorite();
    removeFavorite = MockRemoveFavorite();
    authCubit = MockAuthCubit();

    when(() => authCubit.state).thenReturn(
      const AuthState(
        status: AuthStatus.authenticated,
        session: sampleAuthSession,
      ),
    );
    when(() => authCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  FavoritesCubit buildCubit() {
    return FavoritesCubit(
      getFavorites: getFavorites,
      addFavorite: addFavorite,
      removeFavorite: removeFavorite,
      authCubit: authCubit,
    );
  }

  blocTest<FavoritesCubit, FavoritesState>(
    'fetches favorites and emits success',
    build: () {
      when(() => getFavorites(any())).thenAnswer((_) async => [samplePet]);
      return buildCubit();
    },
    act: (cubit) => cubit.fetchFavorites(),
    expect: () => [
      const FavoritesState(status: FavoritesStatus.loading),
      const FavoritesState(
        status: FavoritesStatus.success,
        favorites: [samplePet],
      ),
    ],
  );
}
