import 'package:equatable/equatable.dart';
import '../../../../core/entities/user.dart';

class AuthProfile extends Equatable {
  final String id;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final User user;

  const AuthProfile({
    required this.id,
    this.username,
    this.email,
    this.phoneNumber,
    required this.user,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phoneNumber,
        user,
      ];

  String get displayName => user.name;

  String? get displayImage => user.imageUrl;
}
