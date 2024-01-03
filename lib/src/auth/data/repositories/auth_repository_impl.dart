import 'package:clean_architecture_bloc/core/errors/exceptions.dart';
import 'package:clean_architecture_bloc/core/errors/failure.dart';
import 'package:clean_architecture_bloc/core/utils/typedef.dart';
import 'package:clean_architecture_bloc/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  //
  const AuthRepositoryImpl(
    this._remoteDataSource,
  );

  final AuthRemoteDataSource _remoteDataSource;

  ///
  @override
  ResultVoid createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    try {
      print('------------------------------------');
      print('AuthRepositoryImpl.createUser: $name, $createdAt, $avatar');
      print('------------------------------------');

      await _remoteDataSource.createUser(
          name: name, createdAt: createdAt, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() {
    throw UnimplementedError();
  }
}
