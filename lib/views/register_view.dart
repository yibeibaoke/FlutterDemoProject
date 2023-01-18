import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:little_sea_otter/constants/routes.dart';

import '../common/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
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
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  log('weak password');
                  showErrorDialog(context, "Password is too weak");
                } else if (e.code == 'email-already-in-use') {
                  log('email already in use');
                  showErrorDialog(context, "Email already in use");
                } else {
                  log(e.code);
                  showErrorDialog(context, "Error: ${e.code}");
                }
              } catch (e) {
                showErrorDialog(context, e.toString());
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, loginRoute);
              },
              child: const Text('Already registered? Login here'))
        ],
      ),
    );
  }
}
