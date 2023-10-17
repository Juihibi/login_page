import 'package:flutter/material.dart';
import 'package:login2_page/pages/login_page.dart';
import 'package:login2_page/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show Login Page
  bool showLoginPage = true;

  //toggle between login page and registerr page
  void togglepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglepages,
      );
    } else {
      return RegisterPage(
        onTap: togglepages,
      );
    }
  }
}
