import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  const AuthUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    this.phone,
    this.imageUrl,
    this.isAdmin,
  });

  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String? imageUrl;
  final bool? isAdmin;

  @override
  List<Object?> get props => [userId, name, email, phone, imageUrl, isAdmin];
}
