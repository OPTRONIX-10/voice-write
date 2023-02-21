import 'package:new_project/services/auth/auth_provider.dart';
import 'package:new_project/services/auth/auth_user.dart';

class AuthServices implements AuthProvider {
  final AuthProvider provider;

  AuthServices(this.provider);

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentuser => provider.currentuser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(email: email, password: password);
  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
