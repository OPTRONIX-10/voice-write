part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user});
}

class AuthStateLoginFailure extends AuthState{
  final Exception exception;
  const AuthStateLoginFailure({required this.exception});
}

class AuthStatNeedsVerification extends AuthState {

  const AuthStatNeedsVerification();
}

class AuthStatLoggedOut extends AuthState {
  const AuthStatLoggedOut();
}

class AuthStateLogOutFailure extends AuthState{
  final Exception exception;
  const AuthStateLogOutFailure({required this.exception});
}


