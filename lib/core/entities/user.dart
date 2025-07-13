import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final bool active;
  final String? imageUrl;
  final String? phoneNumber;
  final String? gender;
  final String? birthDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? unreadNotificationCount;

  const User({
    required this.id,
    required this.name,
    required this.active,
    this.imageUrl,
    this.phoneNumber,
    this.gender,
    this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    this.unreadNotificationCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        active,
        imageUrl,
        phoneNumber,
        gender,
        birthDate,
        createdAt,
        updatedAt,
        unreadNotificationCount,
      ];

  User copyWith({
    int? id,
    String? name,
    bool? active,
    String? imageUrl,
    String? phoneNumber,
    String? gender,
    String? birthDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? unreadNotificationCount,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      unreadNotificationCount:
          unreadNotificationCount ?? this.unreadNotificationCount,
    );
  }
}
