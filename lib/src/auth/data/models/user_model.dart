import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  // empty user object
  const UserModel.empty()
      : super(
          id: '_empty_id',
          name: '_empty_name',
          avatar: '_empty_avatar',
          createdAt: '_empty_createdAt',
        );

  // fromJson is used to convert the json object to dart object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
    );
  }

  // copyWith is used to copy the object
  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? super.id,
      name: name ?? super.name,
      avatar: avatar ?? super.avatar,
      createdAt: createdAt ?? super.createdAt,
    );
  }

  // toJson is used to convert the dart object to json
  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'avatar': super.avatar,
      'createdAt': super.createdAt,
    };
  }
}
