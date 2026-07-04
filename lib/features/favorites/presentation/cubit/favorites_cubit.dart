import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/add_favorite.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/get_favorites.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:flutter_pet_adopt/features/favorites/presentation/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required GetFavorites getFavorites,
    required AddFavorite addFavorite,
    required RemoveFavorite removeFavorite,
    required AuthCubit authCubit,
  })  : _getFavorites = getFavorites,
        _addFavorite = addFavorite,
        _removeFavorite = removeFavorite,
        _authCubit = authCubit,
        super(const FavoritesState()) {
    _authSubscription = _authCubit.stream.listen((authState) {
      if (authState.status == AuthStatus.authenticated &&
          authState.session != null) {
        emit(FavoritesState(
          status: FavoritesStatus.success,
          favorites: authState.session!.favorites,
        ));
      } else if (authState.status == AuthStatus.unauthenticated) {
        emit(const FavoritesState());
      }
    });

    final currentAuth = _authCubit.state;
    if (currentAuth.status == AuthStatus.authenticated &&
        currentAuth.session != null) {
      emit(FavoritesState(
        status: FavoritesStatus.success,
        favorites: currentAuth.session!.favorites,
      ));
    }
  }

  final GetFavorites _getFavorites;
  final AddFavorite _addFavorite;
  final RemoveFavorite _removeFavorite;
  final AuthCubit _authCubit;
  late final StreamSubscription<AuthState> _authSubscription;

  String? get _token => _authCubit.state.session?.token;

  Future<void> fetchFavorites() async {
    final token = _token;
    if (token == null) return;

    emit(state.copyWith(status: FavoritesStatus.loading));

    try {
      final favs = await _getFavorites(token);
      emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favs,
      ));
    } on FailureException catch (error) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        message: error.failure.message,
      ));
    }
  }

  Future<void> toggleFavorite(String petId) async {
    print("token");
    print(_token);
    final token = _token;
    if (token == null) return;

    print(petId);
    final isCurrentlyFav = state.isFavorite(petId);
    final initialFavs = state.favorites;

    try {
      if (isCurrentlyFav) {
        final updated =
            await _removeFavorite(FavoriteParams(token: token, petId: petId));
        emit(state.copyWith(
          status: FavoritesStatus.success,
          favorites: updated,
        ));
      } else {
        final updated =
            await _addFavorite(FavoriteParams(token: token, petId: petId));
        emit(state.copyWith(
          status: FavoritesStatus.success,
          favorites: updated,
        ));
      }
    } on FailureException catch (error) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        favorites: initialFavs,
        message: error.failure.message,
      ));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
