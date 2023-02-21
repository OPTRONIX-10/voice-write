import 'package:flutter/material.dart';
import 'package:new_project/screens/email_verification.dart';
import 'package:new_project/screens/login_page.dart';
import 'package:new_project/screens/sign_up.dart';
import 'package:new_project/services/auth/auth_services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: AuthServices.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthServices.firebase().currentuser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const LoginPage();
                } else {
                  return EmailVerification();
                }
              } else {
                return const SignUp();
              }

            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }
}
