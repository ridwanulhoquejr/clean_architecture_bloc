import 'package:clean_architecture_bloc/core/utils/typedef.dart';
import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';

/// thhis is the contract that the auth repository must implement
/// this contract is used by the use cases to get the user data
/// and by the data sources to get the user data from the network or local storage

abstract class AuthRepository {
  const AuthRepository();

  /// create a user `contract`
  ///
  /// in here, we are saying this returns the Failure in the right, bcz in domain layer we are not sure
  /// what the failure is, it could be a network failure or a server failure
  /// so, actual failure is implemented in the data layer
  ///
  /// benfits of this is, we can use the same failure for different use cases
  ///
  /// `ResultVoid` is a `typedef` that returns `Future<Either<Failure, void>>`
  ResultVoid createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  /// get list of users contract
  ResultFuture<List<User>> getUsers();
}
