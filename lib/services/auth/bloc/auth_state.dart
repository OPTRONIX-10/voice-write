part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingtext;
  const AuthState(
      {required this.isLoading, this.loadingtext = 'Please wait a moment'});
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStatNeedsVerification extends AuthState {
  const AuthStatNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStatLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;

  const AuthStatLoggedOut(
      {required this.exception, required bool isLoading, String? loadingtext})
      : super(isLoading: isLoading, loadingtext: loadingtext);

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception, required isLoading})
      : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool isEmailSent;
  final bool isLoading;

  AuthStateForgotPassword(
      {required this.exception,
      required this.isEmailSent,
      required this.isLoading})
      : super(isLoading: isLoading);
}
