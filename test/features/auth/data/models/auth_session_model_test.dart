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
