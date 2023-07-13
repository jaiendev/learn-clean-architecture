import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/login_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class Login implements UseCaseFuture<bool, Params> {
  final AuthRepository authRepository;
  Login(this.authRepository);

  @override
  Future<Either<Failures, bool>> call(Params params) async {
    if (params.object is! LoginParam) {
      return Left(CannotParseItem());
    }
    return await authRepository.logIn(params);
  }
}
