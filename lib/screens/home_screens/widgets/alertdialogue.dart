import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutDialog{
  Future showalertDialog(BuildContext context){
    return showDialog(context: context, 
    builder: ((context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 82, 81, 81),
        title: const Text('Log out',
        style: TextStyle(
            color: Color.fromARGB(255, 2, 158, 122),
            fontSize: 23,
            fontWeight: FontWeight.bold
          )),
        content: const Text('Are you sure you want to logout?',
        style: TextStyle(
            color: Color.fromARGB(255, 210, 208, 208),
            fontSize: 17
          )),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('Close',
          style: TextStyle(
            color: Colors.red,
            fontSize: 17
          ),),),
          TextButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          }, child: const Text('Log out',
          style: TextStyle(
            color: Color.fromARGB(255, 2, 158, 122),
            fontSize: 17
          )),),
        ],
      );
    }));
  }
}