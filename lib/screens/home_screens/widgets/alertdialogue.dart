import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/widgets/routes.dart';
import 'package:new_project/services/auth/auth_services.dart';

class LogoutDialog {
  Future showalertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 82, 81, 81),
            title: const Text('Log out',
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 158, 122),
                    fontSize: 23,
                    fontWeight: FontWeight.bold)),
            content: const Text('Are you sure you want to logout?',
                style: TextStyle(
                    color: Color.fromARGB(255, 210, 208, 208), fontSize: 17)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.red, fontSize: 17),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await AuthServices.firebase().logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text('Log out',
                    style: TextStyle(
                        color: Color.fromARGB(255, 2, 158, 122), fontSize: 17)),
              ),
            ],
          );
        }));
  }
}
