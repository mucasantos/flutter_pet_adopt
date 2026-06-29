import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/auth/data/models/auth_session_model.dart';

void main() {
  group('AuthSessionModel', () {
    test('parses token and user payload', () {
      final model = AuthSessionModel.fromJson(
        const {
          'token': 'token-123',
          'user': {
            '_id': 'user-1',
            'name': 'Samuel Santos',
            'email': 'samuel@example.com',
            'phone': '+55 11 99999-0000',
            'image': 'https://example.com/avatar.png',
          },
        },
        fallbackEmail: 'fallback@example.com',
      );

      final entity = model.toEntity();

      expect(model.token, 'token-123');
      expect(model.user.name, 'Samuel Santos');
      expect(entity.user.email, 'samuel@example.com');
    });

    test('parses new contract JSON payload correctly', () {
      final model = AuthSessionModel.fromJson(
        const {
          'message': 'Você está autenticado',
          'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiU2FtdWVsIFNhbnRvcyIsImlkIjoiNjc1MGEzOGVjZmM1OWQ0Y2I0OThiZGZjIiwiaWF0IjoxNzgyNzU0MTUzfQ.obfGLMwRscZTvTgp2TNDVgtabnSvmWOVNak2L8chcy0',
          'user': {
            'userId': '6750a38ecfc59d4cb498bdfc',
            'isAdmin': false,
            'username': 'Samuel Santos',
            'email': 'samuel@email.com'
          },
          'pets': [
            {
              '_id': '6758a22860ed7af1fa155da9',
              'name': 'Meu Pet 2',
              'breed': 'Qualquer',
              'gender': 'male',
              'age': 12,
              'weight': 3,
              'color': 'VErde',
              'story': 'Lindo pet. Encontrado na rua, abandonado. MAs muito saudável.',
              'images': [
                'https://tpdedu.s3.ap-southeast-2.amazonaws.com/uploads/2024/03/27192027/bird-scaled.jpg'
              ],
              'isVerified': true,
              'available': true
            }
          ]
        },
        fallbackEmail: 'fallback@example.com',
      );

      final entity = model.toEntity();

      expect(model.token, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiU2FtdWVsIFNhbnRvcyIsImlkIjoiNjc1MGEzOGVjZmM1OWQ0Y2I0OThiZGZjIiwiaWF0IjoxNzgyNzU0MTUzfQ.obfGLMwRscZTvTgp2TNDVgtabnSvmWOVNak2L8chcy0');
      expect(model.user.name, 'Samuel Santos');
      expect(model.user.userId, '6750a38ecfc59d4cb498bdfc');
      expect(entity.user.email, 'samuel@email.com');
      expect(entity.user.isAdmin, false);
      expect(entity.pets.length, 1);
      expect(entity.pets.first.name, 'Meu Pet 2');
      expect(entity.pets.first.id, '6758a22860ed7af1fa155da9');
    });

    test('falls back to request email when user payload is missing', () {
      final model = AuthSessionModel.fromJson(
        const {
          'token': 'token-123',
        },
        fallbackEmail: 'fallback@example.com',
      );

      expect(model.user.email, 'fallback@example.com');
      expect(model.user.name, 'Fallback');
    });

    test('throws when token is missing', () {
      expect(
        () => AuthSessionModel.fromJson(
          const {
            'user': {
              'email': 'samuel@example.com',
            },
          },
          fallbackEmail: 'fallback@example.com',
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
