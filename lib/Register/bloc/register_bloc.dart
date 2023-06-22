import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(const RegisterInitial(
          isLoading: false,
          isEmailErr: false,
          isPassErr: false,
          isConfirmErr: false,
          emailErr: '',
          passErr: '',
          confirmErr: '',
          isShowPass: false,
        )) {
    on<RegisteringEvent>(registering);
    on<RegisterShowPassEvent>(showPass);
    on<RegisterResetStateEvent>(resetState);
  }

  FutureOr<void> registering(
      RegisteringEvent event, Emitter<RegisterState> emit) async {
    final currentState = state as RegisterInitial;

    emit(RegisterInitial(
      isLoading: true,
      isEmailErr: false,
      emailErr: '',
      isPassErr: false,
      passErr: '',
      isConfirmErr: false,
      confirmErr: '',
      isShowPass: currentState.isShowPass,
    ));

    if (event.email.isNotEmpty &&
        event.pass.isNotEmpty &&
        event.confrimPass.isNotEmpty) {
      if (event.pass == event.confrimPass) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.pass);
        } on FirebaseAuthException catch (error) {
          if (error.code == 'email-already-in-use') {
            emit(RegisterInitial(
              isLoading: false,
              isEmailErr: true,
              emailErr: 'This email is already in use',
              isPassErr: false,
              passErr: '',
              isConfirmErr: false,
              confirmErr: '',
              isShowPass: currentState.isShowPass,
            ));
          } else if (error.code == 'invalid-email') {
            emit(RegisterInitial(
              isLoading: false,
              isEmailErr: true,
              emailErr: 'The email address is not valid',
              isPassErr: false,
              passErr: '',
              isConfirmErr: false,
              confirmErr: '',
              isShowPass: currentState.isShowPass,
            ));
          } else if (error.code == 'operation-not-allowed') {
            emit(RegisterInitial(
              isLoading: false,
              isEmailErr: true,
              emailErr: 'Email/password accounts are not enabled',
              isPassErr: false,
              passErr: '',
              isConfirmErr: false,
              confirmErr: '',
              isShowPass: currentState.isShowPass,
            ));
          } else if (error.code == 'weak-password') {
            emit(RegisterInitial(
              isLoading: false,
              isEmailErr: false,
              emailErr: '',
              isPassErr: true,
              passErr: 'The password is not strong enough',
              isConfirmErr: false,
              confirmErr: '',
              isShowPass: currentState.isShowPass,
            ));
          }
        }
      } else {
        emit(RegisterInitial(
          isLoading: false,
          isEmailErr: false,
          emailErr: '',
          isPassErr: false,
          passErr: '',
          isConfirmErr: true,
          confirmErr: 'Password confirmation does not match',
          isShowPass: currentState.isShowPass,
        ));
      }
    } else {
      bool checkEmail = event.email.isEmpty;
      bool checkPass = event.pass.isEmpty;
      bool checkConfirm = event.confrimPass.isEmpty;

      emit(RegisterInitial(
        isLoading: false,
        isEmailErr: checkEmail,
        emailErr: 'Please enter your email',
        isPassErr: checkPass,
        passErr: 'Please enter your password',
        isConfirmErr: checkConfirm,
        confirmErr: 'Please confirm your password',
        isShowPass: currentState.isShowPass,
      ));
    }
  }

  FutureOr<void> showPass(
      RegisterShowPassEvent event, Emitter<RegisterState> emit) {
    final currentState = state as RegisterInitial;

    emit(RegisterInitial(
      isLoading: currentState.isLoading,
      isEmailErr: currentState.isEmailErr,
      emailErr: currentState.emailErr,
      isPassErr: currentState.isPassErr,
      passErr: currentState.passErr,
      isConfirmErr: currentState.isConfirmErr,
      confirmErr: currentState.confirmErr,
      isShowPass: !currentState.isShowPass,
    ));
  }

  FutureOr<void> resetState(
      RegisterResetStateEvent event, Emitter<RegisterState> emit) {
    emit(const RegisterInitial(
      isLoading: false,
      isEmailErr: false,
      isPassErr: false,
      isConfirmErr: false,
      emailErr: '',
      passErr: '',
      confirmErr: '',
      isShowPass: false,
    ));
  }
}
