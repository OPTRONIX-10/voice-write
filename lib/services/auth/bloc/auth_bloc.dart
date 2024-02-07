import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_project/services/auth/auth_provider.dart';
import 'package:new_project/services/auth/auth_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(AuthStateLoading()) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentuser;
      if (user == null) {
        emit(AuthStatLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(AuthStatNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user: user));
      }
    });
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      final user =
          await provider.login(email: event.email, password: event.password);
      try {
        emit(AuthStateLoggedIn(user: user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(exception: e));
      }
    });
    on<AuthEventLogout>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await provider.logout();
        emit(AuthStatLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogOutFailure(exception: e));
      }
    });
  }
}
