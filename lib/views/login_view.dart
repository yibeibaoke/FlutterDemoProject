import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:little_sea_otter/common/show_error_dialog.dart';
import 'package:little_sea_otter/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: "Enter your email address"),
          ),
          TextField(
            controller: _password,
            decoration:
                const InputDecoration(hintText: "Enter a valid password"),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          TextButton(
            onPressed: () async {
              var email = _email.text;
              var password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                log(userCredential.toString());
                if (!mounted) return;
                Navigator.pushNamed(context, storiesRoute);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  log('user not found');
                  showErrorDialog(context, "User not found");
                } else if (e.code == 'wrong-password') {
                  log('wrong password');
                  showErrorDialog(context, "Wrong password");
                } else {
                  log(e.code);
                  showErrorDialog(context, "Error: ${e.code}");
                }
              } catch (e) {
                showErrorDialog(context, e.toString());
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, registerRoute);
              },
              child: const Text('Not registered yet? Register now !'))
        ],
      ),
    );
  }
}
