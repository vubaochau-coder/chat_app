part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  final bool isLoading;
  final bool isEmailErr;
  final String emailErr;
  final bool isPassErr;
  final String passErr;
  final bool isConfirmErr;
  final String confirmErr;
  final bool isShowPass;

  const RegisterInitial({
    required this.isLoading,
    required this.isEmailErr,
    required this.emailErr,
    required this.isPassErr,
    required this.passErr,
    required this.isConfirmErr,
    required this.confirmErr,
    required this.isShowPass,
  });

  @override
  List<Object> get props => [
        isLoading,
        isEmailErr,
        emailErr,
        isPassErr,
        passErr,
        isConfirmErr,
        confirmErr,
        isShowPass
      ];
}
