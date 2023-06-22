import 'package:chat_app/Login/ui/login_page.dart';
import 'package:chat_app/Register/ui/register_page.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'VS Chat',
                style: TextStyle(
                  color: themeColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                LoginPage(onRegisterTap: navigateToRegisterPage),
                RegisterPage(onLoginTap: navigateToLoginPage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  navigateToRegisterPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  navigateToLoginPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
