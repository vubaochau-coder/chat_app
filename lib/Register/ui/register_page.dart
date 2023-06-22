import 'package:chat_app/Register/bloc/register_bloc.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onLoginTap;
  const RegisterPage({super.key, required this.onLoginTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passRegisterController = TextEditingController();
  TextEditingController rePassRegisterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: BlocProvider.of<RegisterBloc>(context)
        ..add(RegisterResetStateEvent()),
      builder: (context, state) {
        if (state is RegisterInitial) {
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
                    'Register',
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24, bottom: state.isEmailErr ? 12 : 28),
                    child: TextField(
                      controller: emailRegisterController,
                      decoration: authInputDecoration(
                          'Email', state.isEmailErr, state.emailErr),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: state.isPassErr ? 12 : 28),
                    child: TextField(
                      controller: passRegisterController,
                      obscureText: !state.isShowPass,
                      decoration: passwordInputDecoration('Password',
                          state.isPassErr, state.passErr, state.isShowPass, () {
                        BlocProvider.of<RegisterBloc>(context)
                            .add(RegisterShowPassEvent());
                      }),
                    ),
                  ),
                  TextField(
                    controller: rePassRegisterController,
                    obscureText: !state.isShowPass,
                    decoration: passwordInputDecoration(
                        'Confirm Password',
                        state.isConfirmErr,
                        state.confirmErr,
                        state.isShowPass, () {
                      BlocProvider.of<RegisterBloc>(context)
                          .add(RegisterShowPassEvent());
                    }),
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
                        onPressed: () {
                          BlocProvider.of<RegisterBloc>(context)
                              .add(RegisteringEvent(
                            email: emailRegisterController.text.trim(),
                            pass: passRegisterController.text.trim(),
                            confrimPass: rePassRegisterController.text.trim(),
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
                                      'Submit',
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
                      text: 'Already have an Account?',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' Log in',
                          style: TextStyle(
                            color: themeColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                state.isLoading ? null : widget.onLoginTap,
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
