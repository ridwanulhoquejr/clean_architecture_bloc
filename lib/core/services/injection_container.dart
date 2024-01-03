import 'package:clean_architecture_bloc/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_bloc/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:clean_architecture_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:clean_architecture_bloc/src/auth/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl

    /// App logic
    ..registerFactory(
      () => AuthenticationCubit(
        createUser: sl(),
        getUsers: sl(),
      ),
    )

    /// Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    /// Repositories
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))

    /// Data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()))

    /// external dependencies
    ..registerLazySingleton(http.Client.new);
}
