part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final bool isLoading;
  final bool isEmailErr;
  final String emailErr;
  final bool isPassErr;
  final String passErr;
  final bool isShowPass;

  const LoginInitial({
    required this.isLoading,
    required this.isEmailErr,
    required this.emailErr,
    required this.isPassErr,
    required this.passErr,
    required this.isShowPass,
  });

  @override
  List<Object> get props =>
      [isLoading, isEmailErr, isPassErr, emailErr, passErr, isShowPass];
}
