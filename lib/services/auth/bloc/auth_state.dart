part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user});
}

class AuthStatNeedsVerification extends AuthState {
  const AuthStatNeedsVerification();
}

class AuthStatLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStatLoggedOut({required this.exception, required this.isLoading});
  
  @override
  
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}
