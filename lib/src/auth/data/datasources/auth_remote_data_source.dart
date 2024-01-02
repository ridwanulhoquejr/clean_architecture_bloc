import 'package:clean_architecture_bloc/src/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// create a user data source contract
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  /// get list of users data source contract
  Future<List<UserModel>> getUsers();
}
