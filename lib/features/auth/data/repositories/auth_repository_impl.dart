import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/data/datasources/auth_local_data.dart';
import 'package:project_learn_clean_architecture/features/auth/data/datasources/auth_remote_data.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/login_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/register_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalData localData;
  final AuthRemoteData remoteData;

  const AuthRepositoryImpl({
    required this.localData,
    required this.remoteData,
  });
  @override
  Either<Failures, bool> checkLogined() {
    String? token = localData.getAccessToken();

    if (token == null) {
      return Left(NullValue());
    }

    return const Right(true);
  }

  @override
  Future<Either<Failures, bool>> logIn(Params params) async {
    String? accessToken = await remoteData.login(
      params.object as LoginParam,
    );

    if (accessToken != null) {
      localData.saveAccessToken(accessToken);
      return const Right(true);
    }

    return const Right(false);
  }

  @override
  Future<Either<Failures, bool>> register(Params params) async {
    final bool isRegisterSuccess = await remoteData.register(
      params.object as RegisterParam,
    );

    return Right(isRegisterSuccess);
  }

  @override
  Either<Failures, bool> logOut() {
    localData.clearAccessToken();
    return const Right(true);
  }
}
