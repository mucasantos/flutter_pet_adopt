import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/core/network/api_config.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/cubit/app_shell_cubit.dart';
import 'package:flutter_pet_adopt/features/pets/data/datasources/pets_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/pets/data/repositories/pets_repository_impl.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_categories.dart';
import 'package:flutter_pet_adopt/features/pets/domain/usecases/get_pets.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> setupDependencies() async {
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

  sl.registerFactory(AppShellCubit.new);
  sl.registerFactory(
    () => PetsCubit(
      getPets: sl<GetPets>(),
      getCategories: sl<GetCategories>(),
    ),
  );
}
