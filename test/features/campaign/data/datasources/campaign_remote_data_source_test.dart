import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/campaign/data/datasources/campaign_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late CampaignRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = CampaignRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('CampaignRemoteDataSource', () {
    const endpoint = '/campaign/modal';

    final mockResponseWithCampaign = {
      'hasCampaign': true,
      'ui': {
        'type': 'modal',
        'properties': {
          'title': 'Campanha de Adoção Especial!',
          'imageUrl': 'https://images.unsplash.com/photo-1543466835-00a7907e9de1',
          'backgroundColor': '#FFFFFF',
          'titleColor': '#333333'
        },
        'primaryButton': {
          'text': 'Quero Adotar',
          'textColor': '#FFFFFF',
          'buttonColor': '#4CAF50',
          'action': {
            'type': 'NAVIGATE_INTERNAL',
            'payload': {
              'route': '/adopt',
              'arguments': {'petId': '123'}
            }
          }
        },
        'secondaryButton': {
          'text': 'Talvez depois',
          'action': {'type': 'CLOSE_MODAL'}
        }
      }
    };

    test('should parse backend response successfully when hasCampaign is true', () async {
      when(() => mockApiClient.get(endpoint)).thenAnswer((_) async => mockResponseWithCampaign);

      final result = await dataSource.getActiveCampaign();

      expect(result, isNotNull);
      expect(result!.properties.title, 'Campanha de Adoção Especial!');
      expect(result.primaryButton.text, 'Quero Adotar');
      expect(result.secondaryButton.text, 'Talvez depois');
    });

    test('should return null when hasCampaign is false', () async {
      when(() => mockApiClient.get(endpoint)).thenAnswer((_) async => {
        'hasCampaign': false,
        'ui': null,
      });

      final result = await dataSource.getActiveCampaign();

      expect(result, isNull);
    });

    test('should fallback to properties check when ui/hasCampaign are missing', () async {
      when(() => mockApiClient.get(endpoint)).thenAnswer((_) async => {
        'properties': {
          'title': 'Old Format Title',
          'imageUrl': '',
          'backgroundColor': '#FFFFFF',
          'titleColor': '#000000',
        },
        'primaryButton': {'text': 'OK'},
        'secondaryButton': {'text': 'Cancel'},
      });

      final result = await dataSource.getActiveCampaign();

      expect(result, isNotNull);
      expect(result!.properties.title, 'Old Format Title');
    });
  });
}
