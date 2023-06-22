import 'package:chat_app/Login/bloc/login_bloc.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onRegisterTap;
  const LoginPage({super.key, required this.onRegisterTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isUnShowPass = true;
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passLoginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: BlocProvider.of<LoginBloc>(context)..add(LoginResetStateEvent()),
      builder: (context, state) {
        if (state is LoginInitial) {
          return Container(
            padding: const EdgeInsets.only(
                left: 16, right: 16, bottom: 124, top: 24),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 28),
                    child: TextField(
                      controller: emailLoginController,
                      decoration: authInputDecoration(
                          'Email', state.isEmailErr, state.emailErr),
                    ),
                  ),
                  TextField(
                    controller: passLoginController,
                    obscureText: !state.isShowPass,
                    decoration: passwordInputDecoration(
                      'Password',
                      state.isPassErr,
                      state.passErr,
                      state.isShowPass,
                      () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginShowPassEvent());
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 172,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      margin: const EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(LogingInEvent(
                                  email: emailLoginController.text.trim(),
                                  password: passLoginController.text.trim(),
                                ));
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor.withOpacity(0.2),
                          elevation: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 0),
                          child: state.isLoading
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Loging In',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1D1B20),
                                      ),
                                    ),
                                    LoadingAnimationWidget.staggeredDotsWave(
                                      color: const Color(0xff1D1B20),
                                      size: 24,
                                    ),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Go to App',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1D1B20),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xff1D1B20),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an Account?',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' Register',
                          style: TextStyle(
                            color: themeColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                state.isLoading ? null : widget.onRegisterTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
