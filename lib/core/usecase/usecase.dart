import 'package:clean_architecture_bloc/core/utils/typedef.dart';

abstract class UsecaseWithParams<T, P> {
  const UsecaseWithParams();
  ResultFuture<T> call(P params);
}

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();

  ResultFuture<T> call();
}
