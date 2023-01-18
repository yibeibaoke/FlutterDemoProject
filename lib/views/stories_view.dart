import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({super.key});

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    if (!mounted) return;
                    Navigator.pushNamed(context, '/login');
                  }
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                    value: MenuAction.logout, child: Text("Logout"))
              ];
            },
          )
        ],
      ),
    );
  }
}

enum MenuAction { logout }

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure to log out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Logout')),
          ],
        );
      }).then((value) => value ?? false);
}
