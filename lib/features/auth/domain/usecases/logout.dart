import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class Logout implements UseCase<bool, NoParams> {
  AuthRepository authRepository;
  Logout(this.authRepository);

  @override
  Either<Failures, bool> call(NoParams params) {
    return authRepository.logOut();
  }
}
