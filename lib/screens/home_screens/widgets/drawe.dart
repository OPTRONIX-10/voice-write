import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_project/screens/home_screens/widgets/alertdialogue.dart';

class Drawerview extends StatelessWidget {
  const Drawerview({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 82, 81, 81),
      child: ListView(
        children: [
          const DrawerHeader(
              child: Text(
            'NOTES',
            style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 158, 122)),
          )),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(
                  color: Color.fromARGB(255, 210, 208, 208), fontSize: 20),
            ),
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 2, 158, 122),
            ),
            onTap: () {
              LogoutDialog().showalertDialog(context);
            },
          )
        ],
      ),
    );
  }
}
