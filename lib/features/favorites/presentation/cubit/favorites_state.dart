import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.message,
  });

  final FavoritesStatus status;
  final List<PetEntity> favorites;
  final String? message;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<PetEntity>? favorites,
    Object? message = _sentinel,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      message: identical(message, _sentinel) ? this.message : message as String?,
    );
  }

  bool isFavorite(String petId) {
    return favorites.any((pet) => pet.id == petId);
  }

  @override
  List<Object?> get props => [status, favorites, message];
}

const _sentinel = Object();
