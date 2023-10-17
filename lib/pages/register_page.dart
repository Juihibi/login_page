import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:login2_page/widgets/my_button.dart';
import 'package:login2_page/widgets/my_textfields.dart';
import 'package:login2_page/widgets/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 25),

      //logo
      const Icon(Icons.lock, size: 50),

      const SizedBox(height: 25),

      //Let's create an account for you
      Text('Let\'s create an account for you',
          style: TextStyle(color: Colors.grey[700], fontSize: 16.0)),

      const SizedBox(height: 25),

      //username
      MyTextField(
        controller: emailController,
        hintText: 'Username',
        obscureText: false,
      ),

      const SizedBox(height: 10),

      //password
      MyTextField(
        controller: passwordController,
        hintText: 'Password',
        obscureText: true,
      ),

      const SizedBox(height: 10),

      //Confirm Password
      MyTextField(
        controller: confirmPasswordController,
        hintText: 'Confirm password',
        obscureText: true,
      ),

      const SizedBox(height: 25),

      //Sign Up Button
      MyButton(text: 'Sign Up', onTap: signUserUp),
      const SizedBox(height: 30),

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
      //const SizedBox(height: 50),
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

      //Already have an account? Loggin  now
      //const SizedBox(height: 50),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Already have an account?',
            style: TextStyle(
                color: Colors.grey[700], fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: widget.onTap,
          child: Text('Login now',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          width: 4,
        ),
      ])
    ]));
  }

  //Sign User In method
  void signUserUp() async {
    //Show loading cercle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    //Try creating User
    try {
      //Check if password is the same
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      }
      //if not show passord don't match
      else {
        showErrorMessage("Passwords don't match!");
      }
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

  //Wrong password message popup
}
