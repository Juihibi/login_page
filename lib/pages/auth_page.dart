import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:login2_page/pages/logged_page.dart';
import 'package:login2_page/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print('Auth state changed: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator here
          return CircularProgressIndicator();
        }

        //If user is logged in
        if (snapshot.hasData) {
          return LoggedPage();
        }
        //if user not logged in
        else {
          return LoginPage();
        }
      },
    ));
  }
}
