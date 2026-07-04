import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient apiClient;
  late FavoritesRemoteDataSourceImpl dataSource;

  setUp(() {
    apiClient = MockApiClient();
    dataSource = FavoritesRemoteDataSourceImpl(apiClient: apiClient);
  });

  const token = 'test-token';

  group('getFavorites', () {
    test('returns list of pet models on success', () async {
      when(() => apiClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => {
            'success': true,
            'favorites': [samplePetModel.toJson()],
          });

      final result = await dataSource.getFavorites(token);

      expect(result, [samplePetModel]);
      verify(() => apiClient.get(
            '/favorites',
            headers: {'Authorization': 'Bearer $token'},
          )).called(1);
    });
  });
}
