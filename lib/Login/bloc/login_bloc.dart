import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginInitial(
          isLoading: false,
          isEmailErr: false,
          emailErr: '',
          isPassErr: false,
          passErr: '',
          isShowPass: false,
        )) {
    on<LogingInEvent>(login);
    on<LoginShowPassEvent>(showPass);
    on<LoginResetStateEvent>(resetState);
  }

  FutureOr<void> login(LogingInEvent event, Emitter<LoginState> emit) async {
    final currentState = state as LoginInitial;

    emit(LoginInitial(
      isLoading: true,
      isEmailErr: false,
      emailErr: '',
      isPassErr: false,
      passErr: '',
      isShowPass: currentState.isShowPass,
    ));

    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'invalid-email') {
          emit(LoginInitial(
            isLoading: false,
            isEmailErr: true,
            emailErr: 'The email address provided is not valid',
            isPassErr: false,
            passErr: '',
            isShowPass: currentState.isShowPass,
          ));
        }
        if (error.code == 'user-disabled') {
          emit(LoginInitial(
            isLoading: false,
            isEmailErr: true,
            emailErr:
                'The user account associated with the provided email has been disabled',
            isPassErr: false,
            passErr: '',
            isShowPass: currentState.isShowPass,
          ));
        }
        if (error.code == 'user-not-found') {
          emit(LoginInitial(
            isLoading: false,
            isEmailErr: true,
            emailErr: 'No user account found for the provided email',
            isPassErr: false,
            passErr: '',
            isShowPass: currentState.isShowPass,
          ));
        }
        if (error.code == 'wrong-password') {
          emit(LoginInitial(
            isLoading: false,
            isEmailErr: false,
            emailErr: '',
            isPassErr: true,
            passErr: 'The password entered is invalid for the given email',
            isShowPass: currentState.isShowPass,
          ));
        }
      }
    } else {
      bool checkEmail = event.email.isEmpty;
      bool checkPass = event.password.isEmpty;

      emit(LoginInitial(
        isLoading: false,
        isEmailErr: checkEmail,
        emailErr: 'Please enter your email address to continue',
        isPassErr: checkPass,
        passErr: 'Please enter your password to proceed',
        isShowPass: currentState.isShowPass,
      ));
    }
  }

  FutureOr<void> showPass(LoginShowPassEvent event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    emit(LoginInitial(
      isLoading: currentState.isLoading,
      isEmailErr: currentState.isEmailErr,
      emailErr: currentState.emailErr,
      isPassErr: currentState.isPassErr,
      passErr: currentState.passErr,
      isShowPass: !currentState.isShowPass,
    ));
  }

  FutureOr<void> resetState(
      LoginResetStateEvent event, Emitter<LoginState> emit) {
    emit(const LoginInitial(
      isLoading: false,
      isEmailErr: false,
      emailErr: '',
      isPassErr: false,
      passErr: '',
      isShowPass: false,
    ));
  }
}
