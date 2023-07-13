// Package imports:
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:project_learn_clean_architecture/core/app/constants/storage_keys.dart';

abstract class AuthLocalData {
  String? getAccessToken();
  void saveAccessToken(String accessToken);
  void clearAccessToken();
}

@LazySingleton(as: AuthLocalData)
class AuthLocalDataSourceImpl implements AuthLocalData {
  final Box hiveBox = Hive.box(StorageKeys.boxAuth);

  @override
  void clearAccessToken() {
    hiveBox.delete(StorageKeys.accessToken);
  }

  @override
  String? getAccessToken() {
    return hiveBox.get(StorageKeys.accessToken);
  }

  @override
  void saveAccessToken(String accessToken) {
    hiveBox.put(StorageKeys.accessToken, accessToken);
  }
}
