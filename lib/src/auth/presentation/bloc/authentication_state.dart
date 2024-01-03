part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// Initial state of the bloc: loading
final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

/// creating user state (createUser)
class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

/// getting users state (getUsers)
class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

/// user created state (createUser)
class UserCreated extends AuthenticationState {
  const UserCreated();
}

/// users loaded state (getUsers)
class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
