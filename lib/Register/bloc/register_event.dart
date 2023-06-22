part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterShowPassEvent extends RegisterEvent {}

class RegisteringEvent extends RegisterEvent {
  final String email;
  final String pass;
  final String confrimPass;

  const RegisteringEvent(
      {required this.email, required this.pass, required this.confrimPass});
}

class RegisterResetStateEvent extends RegisterEvent {}
