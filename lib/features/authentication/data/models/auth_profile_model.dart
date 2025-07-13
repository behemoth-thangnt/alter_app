import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_profile.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/entities/teacher.dart';

part 'auth_profile_model.g.dart';

@JsonSerializable()
class AuthTeacherModel extends Teacher {
  AuthTeacherModel({
    required super.id,
    required super.name,
    required super.slug,
    super.imageUrl,
  }) : super(
          active:
              true, // Default values for required fields not in API response
          basicEntered: true,
          canInviteStudents: false,
          approvedCourseCount: 0,
          studentCount: 0,
          createdAt: DateTime.fromMillisecondsSinceEpoch(0),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        );

  factory AuthTeacherModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTeacherModelToJson(this);
}

@JsonSerializable()
class AuthUserModel extends User {
  AuthUserModel({
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
  @JsonKey(name: 'teacher')
  final AuthTeacherModel? teacherModel;

  @JsonKey(name: 'user')
  final AuthUserModel? userModel;

  const AuthProfileModel({
    required super.id,
    super.username,
    super.email,
    super.phoneNumber,
    this.teacherModel,
    this.userModel,
  }) : super(
          teacher: teacherModel,
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
      teacherModel: profile.teacher != null
          ? AuthTeacherModel(
              id: profile.teacher!.id,
              name: profile.teacher!.name,
              slug: profile.teacher!.slug,
              imageUrl: profile.teacher!.imageUrl,
            )
          : null,
      userModel: profile.user != null
          ? AuthUserModel(
              id: profile.user!.id,
              name: profile.user!.name,
              imageUrl: profile.user!.imageUrl,
              phoneNumber: profile.user!.phoneNumber,
              gender: profile.user!.gender,
              birthDate: profile.user!.birthDate,
              createdAt: profile.user!.createdAt,
              updatedAt: profile.user!.updatedAt,
            )
          : null,
    );
  }
}
