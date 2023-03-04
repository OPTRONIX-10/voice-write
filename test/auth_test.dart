import 'package:new_project/services/auth/auth_exception.dart';
import 'package:new_project/services/auth/auth_provider.dart';
import 'package:new_project/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Auth Prvovider Test', () {
    MockAuthProvider provider = MockAuthProvider();

    test('Should not be initialze to begin with', (() {
      expect(provider._isInitialize, false);
    }));

    test('Cannot logout if not initialised', (() {
      expect(
          provider.logout(), throwsA(const TypeMatcher<MockAuthException>()));
    }));

    test('Should be able to initialize', () async {
      await provider.initialize();
      expect(provider.isInitialize, true);
    });

    test('User should be null after initialization', (() {
      expect(provider.currentuser, null);
    }));

    test('should be able to initialise in less than 2 seconds', (() async {
      await provider.initialize();
      expect(provider.isInitialize, true);
    }), timeout: const Timeout(Duration(seconds: 2)));

    test('Create user should delegate to login', () async {
      final badEmailUser = await provider.createUser(
          email: 'ksabhishek00@gmail.com', password: 'anypassword');

      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = await provider.createUser(
        email: 'hello@google.com',
        password: 'ronaldomessi',
      );
      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(email: 'foo', password: 'bar');
      expect(provider.currentuser, user);
      expect(user.isEmailVerified, false);
    });

    test('Logged in User showuld be verified', (() async {
      await provider.sendEmailVerification();
      final user = provider.currentuser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    }));

    test('Should be able to logout and login', () async {
      await provider.logout();
      await provider.login(email: 'email', password: 'password');
      final user = provider.currentuser;
      expect(user, isNotNull);
    });
  });
}

class MockAuthException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  bool _isInitialize = false;
  bool get isInitialize => _isInitialize;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!_isInitialize) throw MockAuthException();
    await Future.delayed(Duration(seconds: 1));
    return login(email: email, password: password);
  }

  @override
  AuthUser? get currentuser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 1));
    _isInitialize = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!_isInitialize) throw MockAuthException();
    if (email == 'ksabhishek00@gmail.com') throw UserNotFoundAuthException();
    if (password == 'ronaldomessi') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!_isInitialize) throw MockAuthException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!_isInitialize) throw MockAuthException();
    if (_user == null) throw UserNotFoundAuthException();
    const newuser = AuthUser(isEmailVerified: true);
    _user = newuser;
  }
}
