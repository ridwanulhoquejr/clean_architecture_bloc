import 'package:equatable/equatable.dart';

/// this is what a user holds
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  final String id;
  final String name;
  final DateTime createdAt;
  final String avatar;

  // we only check for id, if this is same, then we consider them as same user
  @override
  List<Object?> get props => [id];
}
