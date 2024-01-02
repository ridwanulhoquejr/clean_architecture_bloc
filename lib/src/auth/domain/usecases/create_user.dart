import 'package:clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:clean_architecture_bloc/core/utils/typedef.dart';
import 'package:clean_architecture_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  /// we have to pass the return type of the `usecase` as a type of the `parameter` it takes
  /// in this case, it takes `CreateUserParams` as a parameter and returns `void`
  //
  /// This is the constructor of the `usecase`
  /// This contract depends on the `AuthRepository`, so we pass it as a parameter
  const CreateUser(this._repository);

  final AuthRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
        name: params.name,
        createdAt: params.createdAt,
        avatar: params.avatar,
      );
}

/// This is needed to pass the parameters to the `usecase`
/// Because, it is good practice to pass only one parameter to the `usecase`
/// hence, we create our own `Params` class `CreateUserParams`
class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  final String name;
  final String createdAt;
  final String avatar;

  @override
  List<Object?> get props => [name, createdAt, avatar];
}
