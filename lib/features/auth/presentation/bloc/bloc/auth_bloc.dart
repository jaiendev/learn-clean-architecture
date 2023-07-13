import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/login_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/register_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/usecases/check_logined.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/usecases/logout.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/usecases/login.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckLogined _checkLogined;
  final Login _login;
  final Register _register;
  final Logout _logout;
  AuthBloc(
    this._checkLogined,
    this._login,
    this._logout,
    this._register,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckLoginedEvent) {
        checkLogined(emit);
      }

      if (event is LogInEvent) {
        emit(_authenticating);
        await _logIn(emit, loginParams: event.loginParams);
      }

      if (event is LogOutEvent) {
        _logOut(emit);
      }

      if (event is RegisterEvent) {
        emit(_authenticating);
        await register(emit, registerParams: event.registerParam);
      }
    });
  }

  // MARK: Private methods
  AuthFailure get _authFailure => AuthFailure();
  AuthSuccess get _authSuccess => AuthSuccess();
  Authenticating get _authenticating => Authenticating();

  void checkLogined(Emitter<AuthState> emit) {
    Either<Failures, bool> hasLogined = _checkLogined.call(NoParams());
    hasLogined.fold((l) => emit(_authFailure), (r) => emit(_authSuccess));
  }

  Future<void> _logIn(
    Emitter<AuthState> emit, {
    required LoginParam loginParams,
  }) async {
    Either<Failures, bool> signInSucceed = await _login.call(
      Params(object: loginParams),
    );

    signInSucceed.fold(
      (l) => emit(_authFailure),
      (r) => emit(_authSuccess),
    );
  }

  Future<void> register(
    Emitter<AuthState> emit, {
    required RegisterParam registerParams,
  }) async {
    Either<Failures, bool> registerSucceed = await _register.call(
      Params(object: registerParams),
    );

    registerSucceed.fold(
      (l) => emit(_authFailure),
      (r) => emit(_authSuccess),
    );
  }

  void _logOut(Emitter<AuthState> emit) async {
    Either<Failures, bool> signOutSucceed = _logout.call(NoParams());
    signOutSucceed.fold((l) => l, (r) {
      emit(AuthFailure());
    });
  }
}
