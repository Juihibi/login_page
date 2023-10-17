import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:login2_page/widgets/my_button.dart';
import 'package:login2_page/widgets/my_textfields.dart';
import 'package:login2_page/widgets/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    //Show loading cercle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    //Try sign In
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading cercle
      Navigator.of(context);
    } on FirebaseAuthException catch (e) {
      //Wrong Email
      if (e.code == 'user-notfound') {
        showErrorMessage(e.code);
      }
      //Wrong password
      else if (e.code == 'wrong-password') {
        showErrorMessage(e.code);
      }
    }
  }

  //Wrong password message popup
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // const SizedBox(height: 50),

        //loggo
        const Icon(Icons.lock, size: 75),
        const SizedBox(height: 30),

        //Welcome back, you've been missed'
        Text('Welcome back, you\'ve been missed',
            style: TextStyle(color: Colors.grey[700], fontSize: 16.0)),

        const SizedBox(height: 25),

        //Username
        MyTextField(
          controller: emailController,
          hintText: 'Username',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        //Password
        MyTextField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
        ),

        const SizedBox(height: 10),

        //Forgot pasword
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot pasword?',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        //sign in button
        MyButton(text: 'Sign In', onTap: signUserIn),
        const SizedBox(height: 50),

        //Or continue with
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(thickness: 0.5, color: Colors.grey[400]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Or continue with',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Expanded(
                child: Divider(thickness: 0.5, color: Colors.grey[400]),
              ),
            ],
          ),
        ),

        //google + apple images sign in buttons
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SquareTile(

              //google button
              imagePath: 'assets/images/google.png'),
          const SizedBox(
            width: 10,
          ),

          //apple button
          SquareTile(imagePath: 'assets/images/apple.png')
        ]),

        //Not a member? Register  now
        const SizedBox(height: 25),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Not a member?',
              style: TextStyle(
                  color: Colors.grey[700], fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: widget.onTap,
            child: Text('Register now',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            width: 4,
          ),
        ])
      ]),
    ));
  }
}
