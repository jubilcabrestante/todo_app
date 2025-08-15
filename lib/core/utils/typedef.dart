import 'package:dartz/dartz.dart';
import 'package:todo_app/core/utils/error_handler.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
