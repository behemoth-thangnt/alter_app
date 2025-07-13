import 'package:json_annotation/json_annotation.dart';
import '../../../../core/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.active,
    super.imageUrl,
    super.phoneNumber,
    super.gender,
    super.birthDate,
    required super.createdAt,
    required super.updatedAt,
    super.unreadNotificationCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      active: user.active,
      imageUrl: user.imageUrl,
      phoneNumber: user.phoneNumber,
      gender: user.gender,
      birthDate: user.birthDate,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      unreadNotificationCount: user.unreadNotificationCount,
    );
  }
}
