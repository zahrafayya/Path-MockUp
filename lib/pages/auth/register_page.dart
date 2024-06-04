import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_mock_up/components/sign_up_button.dart';
import 'package:path_mock_up/pages/auth/login_page.dart';

import '../../components/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  // sign up method
  void signUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // make sure password matches
    if (passwordController.text != confirmController.text) {
      Navigator.pop(context);
      wrongMessage(context);
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        wrongMessage(context);
      }
    }
  }

  // wrong email message popup
  void wrongMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Invalid Credential',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void changeToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC03027),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                'lib/images/path_text.png',
                height: 50,
              ),

              const SizedBox(height: 60),

              // email textfield
              AuthTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 15),

              // password textfield
              AuthTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 15),

              // comfirm password textfield
              AuthTextField(
                controller: confirmController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),


              const SizedBox(height: 50),

              // sign up button
              SignUpButton(
                onTap: signUp,
              ),

              const SizedBox(height: 50),

              // already have an account? login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: changeToLogin,
                    child: const Text (
                      'Log in',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

