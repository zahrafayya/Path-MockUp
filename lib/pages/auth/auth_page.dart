import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_mock_up/pages/auth/login_or_register_page.dart';
import './login_page.dart';
import '../app/home_page.dart';

class AuthPage extends StatelessWidget {
  final Function()? onTap;
  const AuthPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          // user is NOT logged in
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}