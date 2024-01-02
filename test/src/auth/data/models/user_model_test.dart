import 'dart:convert';
import 'package:clean_architecture_bloc/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

/// 3 questions to ask yourself before writing a test
/// 1. What are you testing?
/// 2. What should it do?
/// 3. What is the actual output?

void main() {
  const tUserModel = UserModel.empty();
  test('should be a sub class of entity', () {
    // arrange
    // act
    // assert
    expect(tUserModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tUser = jsonDecode(tJson);
  final jEncode = jsonEncode(tJson);

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // arrange
      final result = UserModel.fromJson(tUser);
      debugPrint(result.toString());
      debugPrint(result.runtimeType.toString());
      expect(result, equals(tUserModel));

      // act

      // assert
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // arrange

      // act
      final result = tUserModel.toJson();

      // assert
      expect(result, equals(jEncode));
    });
  });
}
