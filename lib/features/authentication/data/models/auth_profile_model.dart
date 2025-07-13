import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_profile.dart';
import '../../../../core/entities/user.dart';

part 'auth_profile_model.g.dart';

@JsonSerializable()
class AuthUserModel extends User {
  const AuthUserModel({
    required super.id,
    required super.name,
    super.imageUrl,
    super.phoneNumber,
    super.gender,
    super.birthDate,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
          active:
              true, // Default value for required field not in sign-in response
        );

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}

@JsonSerializable()
class AuthProfileModel extends AuthProfile {
  @JsonKey(name: 'user')
  final AuthUserModel userModel;

  const AuthProfileModel({
    required super.id,
    super.username,
    super.email,
    super.phoneNumber,
    required this.userModel,
  }) : super(
          user: userModel,
        );

  factory AuthProfileModel.fromJson(Map<String, dynamic> json) =>
      _$AuthProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthProfileModelToJson(this);

  factory AuthProfileModel.fromEntity(AuthProfile profile) {
    return AuthProfileModel(
      id: profile.id,
      username: profile.username,
      email: profile.email,
      phoneNumber: profile.phoneNumber,
      userModel: AuthUserModel(
        id: profile.user.id,
        name: profile.user.name,
        imageUrl: profile.user.imageUrl,
        phoneNumber: profile.user.phoneNumber,
        gender: profile.user.gender,
        birthDate: profile.user.birthDate,
        createdAt: profile.user.createdAt,
        updatedAt: profile.user.updatedAt,
      ),
    );
  }
}
