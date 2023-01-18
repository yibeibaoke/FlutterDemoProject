import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Register')),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/verify_email');
                  },
                  child: const Text('Verifiy Email')),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/stories');
                  },
                  child: const Text('Stories')),
            ],
          )
        ],
      ),
    );
  }
}
