part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// Event means, user click on the button
/// This eventt means that the user is trying to create a new user
/// And we have to take the name, createdAt and avatar from the UI
class CreateUserEvent extends AuthenticationEvent {
  final String name;
  final String createdAt;
  final String avatar;

  const CreateUserEvent({
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  @override
  List<Object> get props => [name, createdAt, avatar];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
