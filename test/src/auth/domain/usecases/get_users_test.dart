import 'package:clean_architecture_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  // first we need to have the upper level dependencies, which is the repository
  late MockAuthRepository repository;

  // then we need to have the usecase, which is the `GetUsers` usecase
  late GetUsers usecase;

  // then we need to setup the dependencies
  setUpAll(() {
    repository = MockAuthRepository();
    usecase = GetUsers(repository);
  });

  const testResponse = [User.empty()];
  test('should call [AuthRepo.getUsers] and returns [List<Users>]', () async {
    /// arrange
    when(
      () => repository.getUsers(),
    ).thenAnswer((_) async => const Right(testResponse));

    /// act
    final result = await usecase();

    /// assert
    expect(result, equals(const Right<dynamic, List<User>>(testResponse)));
    verify(() => repository.getUsers()).called(1);

    /// verifyNoMoreInteractions is used to make sure that there are no more interactions with the repository
    verifyNoMoreInteractions(repository);
  });
}
