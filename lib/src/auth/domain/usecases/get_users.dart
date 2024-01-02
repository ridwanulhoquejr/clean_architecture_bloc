import 'package:clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:clean_architecture_bloc/core/utils/typedef.dart';
import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/repositories/auth_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
