part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final RegisterParam registerParam;
  const RegisterEvent({required this.registerParam});
}

class CheckLoginedEvent extends AuthEvent {}

class LogInEvent extends AuthEvent {
  final LoginParam loginParams;
  const LogInEvent({required this.loginParams});
}

class LogOutEvent extends AuthEvent {}
