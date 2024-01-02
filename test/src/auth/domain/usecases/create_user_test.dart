import 'package:clean_architecture_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  //
  /// This is the `usecase` we are going to test
  late CreateUser usecase;
  late MockAuthRepository repository;

  setUpAll(() {
    // Arrange
    repository = MockAuthRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
    'should call the [AuthRepository.createUser]',
    () async {
      /// Arrange
      ///
      /// this is called `stubbing`, we are saying, when the `createUser` is called, return `Right(null)`
      // Basically, we are hijacking the upper levels response and returning our own response
      when(
        () => repository.createUser(
          name: any(named: 'name'),
          createdAt: any(named: 'createdAt'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      /// Act
      final result = await usecase(params);

      /// Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createUser(
          name: params.name,
          createdAt: params.createdAt,
          avatar: params.avatar,
        ),
      ).called(1);

      /// verifyNoMoreInteractions is used to make sure that there are no more interactions with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
