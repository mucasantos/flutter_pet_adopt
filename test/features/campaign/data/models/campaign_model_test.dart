import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/campaign/data/models/campaign_model.dart';

void main() {
  group('CampaignModel', () {
    final Map<String, dynamic> sampleJson = {
      'properties': {
        'backgroundColor': '#FF5733',
        'title': 'Test Campaign',
        'titleColor': '#FFFFFF',
        'imageUrl': 'https://example.com/image.jpg',
      },
      'primaryButton': {
        'buttonColor': '#FFFFFF',
        'textColor': '#000000',
        'text': 'Go',
        'action': {
          'type': 'OPEN_EXTERNAL_URL',
          'payload': {'url': 'https://google.com'},
        },
      },
      'secondaryButton': {
        'buttonColor': '#000000',
        'textColor': '#FFFFFF',
        'text': 'Later',
        'action': {
          'type': 'CLOSE_MODAL',
          'payload': {},
        },
      },
    };

    test('should parse correctly from json', () {
      final model = CampaignModel.fromJson(sampleJson);

      expect(model.properties.backgroundColor, '#FF5733');
      expect(model.properties.title, 'Test Campaign');
      expect(model.properties.imageUrl, 'https://example.com/image.jpg');
      expect(model.primaryButton.text, 'Go');
      expect(model.primaryButton.action.type, 'OPEN_EXTERNAL_URL');
      expect(model.primaryButton.action.payload['url'], 'https://google.com');
      expect(model.secondaryButton.text, 'Later');
      expect(model.secondaryButton.action.type, 'CLOSE_MODAL');
    });

    test('should fallback to defaults when properties are missing', () {
      final Map<String, dynamic> partialJson = {
        'properties': {},
        'primaryButton': {},
        'secondaryButton': {},
      };

      final model = CampaignModel.fromJson(partialJson);

      expect(model.properties.backgroundColor, '#FFFFFF');
      expect(model.properties.title, '');
      expect(model.primaryButton.buttonColor, '#000000');
      expect(model.secondaryButton.action.type, 'CLOSE_MODAL');
    });

    test('should throw FormatException when structure is invalid', () {
      final Map<String, dynamic> badJson = {
        'properties': 'not a map',
        'primaryButton': {},
        'secondaryButton': {},
      };

      expect(() => CampaignModel.fromJson(badJson), throwsFormatException);
    });

    test('should convert back to json matching the original values', () {
      final model = CampaignModel.fromJson(sampleJson);
      final json = model.toJson();

      expect(json['properties']['backgroundColor'], '#FF5733');
      expect(json['primaryButton']['text'], 'Go');
      expect(json['secondaryButton']['action']['type'], 'CLOSE_MODAL');
    });
  });
}
