part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogingInEvent extends LoginEvent {
  final String email;
  final String password;

  const LogingInEvent({required this.email, required this.password});
}

class LoginShowPassEvent extends LoginEvent {}

class LoginResetStateEvent extends LoginEvent {}
