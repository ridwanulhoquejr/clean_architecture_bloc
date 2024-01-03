import 'dart:convert';

import 'package:clean_architecture_bloc/core/errors/exceptions.dart';
import 'package:clean_architecture_bloc/src/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

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

const kGetUserEndpoint =
    'https://6593d7bf1493b0116069416e.mockapi.io/test-api/users';
const kCreateUserEndpoint =
    'https://6593d7bf1493b0116069416e.mockapi.io/test-api/users';

/// create a user data source implementation
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(kCreateUserEndpoint),
        body: jsonEncode({
          'name': name,
          'createdAt': createdAt,
          'avatar': avatar,
        }),
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse(kGetUserEndpoint),
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      final List<UserModel> users = (jsonDecode(response.body) as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      return users;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
