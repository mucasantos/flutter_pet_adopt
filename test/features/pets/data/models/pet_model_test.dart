import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/category_model.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/pet_model.dart';

void main() {
  group('PetModel', () {
    test('parses JSON and maps to entity', () {
      final model = PetModel.fromJson(const {
        '_id': 'pet-1',
        'name': 'Milo',
        'images': ['https://example.com/milo.png'],
        'age': '2',
        'weight': 4,
        'color': 'Orange',
        'gender': 'male',
        'breed': 'Tabby',
        'story': 'Friendly cat that loves naps.',
        'category': {
          '_id': 'cat',
          'name': 'Cat',
        },
        'isVerified': 'true',
        'available': true,
      });

      final entity = model.toEntity();

      expect(model.id, 'pet-1');
      expect(model.categoryId, 'cat');
      expect(model.age, 2);
      expect(model.isVerified, isTrue);
      expect(entity.name, 'Milo');
      expect(entity.categoryName, 'Cat');
      expect(entity.images, ['https://example.com/milo.png']);
    });

    test('throws when required fields are missing', () {
      expect(
        () => PetModel.fromJson(const {
          'images': ['https://example.com/milo.png'],
        }),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('CategoryModel', () {
    test('parses JSON and maps to entity', () {
      final model = CategoryModel.fromJson(const {
        '_id': 'cat',
        'name': 'Cat',
        'image': 'https://example.com/cat.png',
      });

      final entity = model.toEntity();

      expect(model.id, 'cat');
      expect(entity.name, 'Cat');
      expect(entity.imageUrl, 'https://example.com/cat.png');
    });

    test('throws when required fields are missing', () {
      expect(
        () => CategoryModel.fromJson(
          const {'image': 'https://example.com/cat.png'},
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
