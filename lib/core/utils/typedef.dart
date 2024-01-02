import 'package:clean_architecture_bloc/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

/// `Future List<T>`
/// This `T` should be passed from call side, where the usecase is uses
/// and left hand `T` is the same as in the `Either<Failure, T>`
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// `Future Void`
typedef ResultVoid = ResultFuture<void>;
