import 'package:equatable/equatable.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/entities/teacher.dart';

class AuthProfile extends Equatable {
  final String id;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final Teacher? teacher;
  final User? user;

  const AuthProfile({
    required this.id,
    this.username,
    this.email,
    this.phoneNumber,
    this.teacher,
    this.user,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phoneNumber,
        teacher,
        user,
      ];

  bool get isTeacher => teacher != null;
  bool get isUser => user != null;

  String get displayName {
    if (teacher != null) return teacher!.name;
    if (user != null) return user!.name;
    return username ?? email ?? phoneNumber ?? 'Unknown';
  }

  String? get displayImage {
    if (teacher != null) return teacher!.imageUrl;
    if (user != null) return user!.imageUrl;
    return null;
  }
}
