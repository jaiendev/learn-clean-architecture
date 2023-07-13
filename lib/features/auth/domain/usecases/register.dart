import 'package:dartz/dartz.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/register_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Register implements UseCaseFuture<bool, Params> {
  final AuthRepository authRepository;
  Register(this.authRepository);

  @override
  Future<Either<Failures, bool>> call(Params params) async {
    if (params is! RegisterParam) {
      return Left(CannotFoundItem());
    }

    return await authRepository.register(params);
  }
}
