import 'package:bloc/bloc.dart';
import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show debugPrint;

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  // create user method
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    /// emit the state of creating user: loading
    emit(const CreatingUser());

    debugPrint('create user cubit called');
    debugPrint('name: $name');
    debugPrint('createdAt: $createdAt');
    debugPrint('avatar: $avatar');

    /// create a user usecase
    final result = await _createUser(
      CreateUserParams(
        name: name,
        createdAt: createdAt,
        avatar: avatar,
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

  /// get users method
  Future<void> getUsers() async {
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
