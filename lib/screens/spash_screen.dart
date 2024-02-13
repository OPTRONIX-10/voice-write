import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/screens/email_verification.dart';
import 'package:new_project/screens/home_screens/front_page.dart';
import 'package:new_project/screens/login_page.dart';
import 'package:new_project/screens/sign_up.dart';

import 'package:new_project/services/auth/bloc/auth_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
      if (state is AuthStateLoggedIn) {
        return MainNotes();
      } else if (state is AuthStatNeedsVerification) {
        return EmailVerification();
      } else if (state is AuthStatLoggedOut) {
        return LoginPage();
      } else if (state is AuthStateRegistering) {
        return SignUp();
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    }));
  }
}
