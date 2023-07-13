import 'package:dartz/dartz.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';

abstract class AuthRepository {
  Future<Either<Failures, bool>> register(
    Params params,
  );

  Future<Either<Failures, bool>> logIn(
    Params params,
  );

  Either<Failures, bool> checkLogined();

  Either<Failures, bool> logOut();
}
