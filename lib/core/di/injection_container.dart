import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/core/network/api_config.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/cubit/app_shell_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_pet_adopt/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_pet_adopt/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/get_saved_session.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/login.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/logout.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/data/datasources/pets_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/pets/data/repositories/pets_repository_impl.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_categories.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pets.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pet_by_id.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:flutter_pet_adopt/features/campaign/data/datasources/campaign_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/campaign/data/repositories/campaign_repository_impl.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/repositories/campaign_repository.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/usecases/get_active_campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_cubit.dart';
import 'package:flutter_pet_adopt/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/get_favorites.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/add_favorite.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:flutter_pet_adopt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  if (!sl.isRegistered<SharedPreferences>()) {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  if (!sl.isRegistered<http.Client>()) {
    sl.registerLazySingleton<http.Client>(http.Client.new);
  }

  if (!sl.isRegistered<ApiClient>()) {
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(
        client: sl<http.Client>(),
        host: ApiConfig.host,
      ),
    );
  }

  if (!sl.isRegistered<AuthRemoteDataSource>()) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );
  }

  if (!sl.isRegistered<AuthLocalDataSource>()) {
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        sharedPreferences: sl<SharedPreferences>(),
      ),
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        localDataSource: sl<AuthLocalDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<Login>()) {
    sl.registerLazySingleton<Login>(
      () => Login(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<GetSavedSession>()) {
    sl.registerLazySingleton<GetSavedSession>(
      () => GetSavedSession(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<Logout>()) {
    sl.registerLazySingleton<Logout>(
      () => Logout(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<PetsRemoteDataSource>()) {
    sl.registerLazySingleton<PetsRemoteDataSource>(
      () => PetsRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );
  }

  if (!sl.isRegistered<PetsRepository>()) {
    sl.registerLazySingleton<PetsRepository>(
      () => PetsRepositoryImpl(
        remoteDataSource: sl<PetsRemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<GetPets>()) {
    sl.registerLazySingleton<GetPets>(
      () => GetPets(sl<PetsRepository>()),
    );
  }

  if (!sl.isRegistered<GetCategories>()) {
    sl.registerLazySingleton<GetCategories>(
      () => GetCategories(sl<PetsRepository>()),
    );
  }

  if (!sl.isRegistered<GetPetById>()) {
    sl.registerLazySingleton<GetPetById>(
      () => GetPetById(sl<PetsRepository>()),
    );
  }

  // Campaign feature registrations
  if (!sl.isRegistered<CampaignRemoteDataSource>()) {
    sl.registerLazySingleton<CampaignRemoteDataSource>(
      () => CampaignRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );
  }

  if (!sl.isRegistered<CampaignRepository>()) {
    sl.registerLazySingleton<CampaignRepository>(
      () => CampaignRepositoryImpl(
        remoteDataSource: sl<CampaignRemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<GetActiveCampaign>()) {
    sl.registerLazySingleton<GetActiveCampaign>(
      () => GetActiveCampaign(sl<CampaignRepository>()),
    );
  }

  // Favorites Feature
  if (!sl.isRegistered<FavoritesRemoteDataSource>()) {
    sl.registerLazySingleton<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );
  }

  if (!sl.isRegistered<FavoritesRepository>()) {
    sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        remoteDataSource: sl<FavoritesRemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<GetFavorites>()) {
    sl.registerLazySingleton<GetFavorites>(
      () => GetFavorites(sl<FavoritesRepository>()),
    );
  }

  if (!sl.isRegistered<AddFavorite>()) {
    sl.registerLazySingleton<AddFavorite>(
      () => AddFavorite(sl<FavoritesRepository>()),
    );
  }

  if (!sl.isRegistered<RemoveFavorite>()) {
    sl.registerLazySingleton<RemoveFavorite>(
      () => RemoveFavorite(sl<FavoritesRepository>()),
    );
  }

  sl.registerFactory(
    () => FavoritesCubit(
      getFavorites: sl<GetFavorites>(),
      addFavorite: sl<AddFavorite>(),
      removeFavorite: sl<RemoveFavorite>(),
      authCubit: sl<AuthCubit>(),
    ),
  );

  sl.registerFactory(
    () => CampaignCubit(
      getActiveCampaign: sl<GetActiveCampaign>(),
    ),
  );

  sl.registerLazySingleton(
    () => AuthCubit(
      login: sl<Login>(),
      getSavedSession: sl<GetSavedSession>(),
      logout: sl<Logout>(),
    ),
  );
  sl.registerFactory(AppShellCubit.new);
  sl.registerFactory(
    () => PetsCubit(
      getPets: sl<GetPets>(),
      getCategories: sl<GetCategories>(),
    ),
  );
}
