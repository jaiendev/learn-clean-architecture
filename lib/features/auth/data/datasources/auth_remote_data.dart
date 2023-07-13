import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_learn_clean_architecture/core/app/config/base_repository.dart';
import 'package:project_learn_clean_architecture/core/app/types/status_code.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/login_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/register_param.dart';

abstract class AuthRemoteData {
  Future<bool> register(RegisterParam param);

  Future<String?> login(LoginParam param);
}

@LazySingleton(as: AuthRemoteData)
class AuthRemoteDataImpl implements AuthRemoteData {
  @override
  Future<String?> login(LoginParam param) async {
    Map<String, dynamic> body = param.toMap();
    Response response = await BaseRepostory().postRoute(
      '/login',
      body,
    );

    if (response.statusCode == StatusCode.ok) {
      return response.data['data']['token'];
    }

    return null;
  }

  @override
  Future<bool> register(RegisterParam param) async {
    Map<String, dynamic> body = param.toMap();
    Response response = await BaseRepostory().postRoute(
      '/register',
      body,
    );

    if (response.statusCode == StatusCode.ok) {
      return true;
    }

    return false;
  }
}
