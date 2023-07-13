// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/auth/data/datasources/auth_local_data.dart' as _i3;
import '../../features/auth/data/datasources/auth_remote_data.dart' as _i4;
import '../../features/auth/data/repositories/auth_repository_impl.dart' as _i6;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i5;
import '../../features/auth/domain/usecases/check_logined.dart' as _i7;
import '../../features/auth/domain/usecases/logout.dart' as _i8;
import '../../features/auth/domain/usecases/login.dart' as _i9;
import '../../features/auth/domain/usecases/register.dart' as _i10;
import '../../features/auth/presentation/bloc/bloc/auth_bloc.dart' as _i11;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AuthLocalData>(() => _i3.AuthLocalDataSourceImpl());
  gh.lazySingleton<_i4.AuthRemoteData>(() => _i4.AuthRemoteDataImpl());
  gh.lazySingleton<_i5.AuthRepository>(() => _i6.AuthRepositoryImpl(
        localData: gh<_i3.AuthLocalData>(),
        remoteData: gh<_i4.AuthRemoteData>(),
      ));
  gh.lazySingleton<_i7.CheckLogined>(
      () => _i7.CheckLogined(gh<_i5.AuthRepository>()));
  gh.lazySingleton<_i8.Logout>(() => _i8.Logout(gh<_i5.AuthRepository>()));
  gh.lazySingleton<_i9.Login>(() => _i9.Login(gh<_i5.AuthRepository>()));
  gh.lazySingleton<_i10.Register>(
      () => _i10.Register(gh<_i5.AuthRepository>()));
  gh.factory<_i11.AuthBloc>(() => _i11.AuthBloc(
        gh<_i7.CheckLogined>(),
        gh<_i9.Login>(),
        gh<_i8.Logout>(),
        gh<_i10.Register>(),
      ));
  return getIt;
}
