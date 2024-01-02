import 'package:equatable/equatable.dart';

/// this is what a user holds
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  /// empty `User` object
  const User.empty()
      : id = 0,
        name = '_empty_name',
        createdAt = '_empty_createdAt',
        avatar = '_empty_avatar';

  final int id;
  final String name;
  final String createdAt;
  final String avatar;

  // we only check for id, if this is same, then we consider them as same user
  @override
  List<Object?> get props => [id];
}
