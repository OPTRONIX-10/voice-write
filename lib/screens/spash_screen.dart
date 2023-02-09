import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 237, 237),
      body: FutureBuilder(
        future:Firebase.initializeApp(
                          options: DefaultFirebaseOptions.currentPlatform,),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if(user?.emailVerified ?? false){
                print('Email is verified');
              }else{
                print('Email not verified');
              }
              return const Text('Done');
            default : return const Text('Loading');
          }
          
        },          
    ),
         
      );
  }
}