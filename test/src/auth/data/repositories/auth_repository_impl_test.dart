import 'package:clean_architecture_bloc/core/errors/exceptions.dart';
import 'package:clean_architecture_bloc/core/errors/failure.dart';
import 'package:clean_architecture_bloc/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_bloc/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepositoryImpl extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRepositoryImpl();
    repoImpl = AuthRepositoryImpl(remoteDataSource);
  });

  group('createUser', () {
    const name = 'nightboot';
    const createdAt = 'whatever date';
    const avatar = 'whatever avatar';
    test(
      'should call [RemoteDataSource.createUser] and complte successfully when thhe call to the remote source is successful',
      () async {
        // arrange
        when(
          () => remoteDataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer((_) async => Future.value());

        // act
        final result = await repoImpl.createUser(
            name: name, createdAt: createdAt, avatar: avatar);

        //assert
        expect(result, equals(const Right(null)));
        verify(() => remoteDataSource.createUser(
              name: name,
              createdAt: createdAt,
              avatar: avatar,
            )).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        // check if the remote data source is called
        // verify(() => remoteDataSource.createUser(
        //       name: name,
        //       createdAt: createdAt,
        //       avatar: avatar,
        //     )).called(1);
        // verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
        'shoould return a [ServerFailure] when the call to the rmote source is unsuccessful',
        () async {
      // arrange
      when(() => remoteDataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          )).thenThrow(
        const ApiException(
          message: 'Something went wrong, please try again later.',
          statusCode: 500,
        ),
      );

      // act
      final result = await repoImpl.createUser(
          name: name, createdAt: createdAt, avatar: avatar);

      // assert
      expect(
          result,
          equals(const Left(
            ApiFailure(
              message: 'Something went wrong, please try again later.',
              statusCode: 500,
            ),
          )));
      verify(() => remoteDataSource.createUser(
            name: name,
            createdAt: createdAt,
            avatar: avatar,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
