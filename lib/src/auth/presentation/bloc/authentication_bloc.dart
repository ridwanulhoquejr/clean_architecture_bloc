import 'package:bloc/bloc.dart';
import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  // create user handler
  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    /// emit the state of creating user: loading
    emit(const CreatingUser());

    /// create a user usecase
    final result = await _createUser(
      CreateUserParams(
        name: event.name,
        createdAt: event.createdAt,
        avatar: event.avatar,
      ),
    );

    /// if the result is success, emit the state of user created
    result.fold(
      (l) => emit(
        AuthenticationError(l.errorMessage),
      ),
      (_) => emit(const UserCreated()),
    );
  }

  /// userHandler
  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    /// emit the state of getting users: loading
    emit(const GettingUsers());

    /// get users usecase
    final result = await _getUsers();

    /// if the result is success, emit the state of users loaded
    result.fold(
      (l) => emit(
        AuthenticationError(l.errorMessage),
      ),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
