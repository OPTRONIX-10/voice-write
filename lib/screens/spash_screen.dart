import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/email_verification.dart';
import 'package:new_project/screens/login_page.dart';
import 'package:new_project/screens/sign_up.dart';

import '../firebase_options.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future:Firebase.initializeApp(
                          options: DefaultFirebaseOptions.currentPlatform,),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if(user!=null){
                if(user.emailVerified){
                  return LoginPage();
                }
                else{
                  return EmailVerification();
                }
              }
              else{
                return SignUp();
              }
              
            default : return const Text('Loading');
          }
          
        },          
    ),
         
      );
  }
}