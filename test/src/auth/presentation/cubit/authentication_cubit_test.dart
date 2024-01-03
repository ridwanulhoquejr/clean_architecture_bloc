import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_bloc/core/errors/failure.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:clean_architecture_bloc/src/auth/presentation/cubit/authentication_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  /// destroy the cubit after each test
  tearDown(() {
    cubit.close();
  });

  test('initial state should be [AthentiacationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest(
      'should emit [CreatingUser, UserCreated] when the user is created',
      build: () {
        /// stub the createUser usecase
        when(() => createUser(any()))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },

      /// act
      act: (cubit) => cubit.createUser(
        name: tCreateUserParams.name,
        createdAt: tCreateUserParams.createdAt,
        avatar: tCreateUserParams.avatar,
      ),

      /// expect
      expect: () => const <AuthenticationState>[
        CreatingUser(),
        UserCreated(),
      ],

      /// verify
      verify: (_) {
        /// verify the createUser usecase is called
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  // for Failure

  const tAPIFailure = ApiFailure(
    message: 'Error creating user',
    statusCode: 500,
  );
  group('createUser failure', () {
    blocTest(
      'should emit [CreatingUser, AuthenticationError] when the user is not created',
      build: () {
        /// stub the createUser usecase
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },

      /// act
      act: (cubit) => cubit.createUser(
        name: tCreateUserParams.name,
        createdAt: tCreateUserParams.createdAt,
        avatar: tCreateUserParams.avatar,
      ),

      /// expect
      expect: () => <AuthenticationState>[
        const CreatingUser(),
        AuthenticationError(tAPIFailure.errorMessage),
      ],

      /// verify
      verify: (_) {
        /// verify the createUser usecase is called
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  /// get user
  group('getUsers', () {
    blocTest(
      'should emit [GettingUsers, UsersLoaded] when the users are loaded',
      build: () {
        /// stub the getUsers usecase
        when(() => getUsers()).thenAnswer(
          (_) async => const Right([]),
        );
        return cubit;
      },

      /// act
      act: (cubit) => cubit.getUsers(),

      /// expect
      expect: () => const <AuthenticationState>[
        GettingUsers(),
        UsersLoaded([]),
      ],

      /// verify
      verify: (_) {
        /// verify the getUsers usecase is called
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
