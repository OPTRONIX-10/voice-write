import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/widgets/generic_dialogue.dart';

Future<bool> showalertDialog(BuildContext context) {
  return showGenericDialoge<bool>(
    context: context,
    titile: 'Log Out',
    content: 'Are you sure you want to Log out?',
    optionsBuilder: (() => {'cancel': false, 'Log out': true}),
  ).then((value) => value ?? false);
}
