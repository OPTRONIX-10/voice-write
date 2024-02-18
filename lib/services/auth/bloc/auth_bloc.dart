import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_project/services/auth/auth_provider.dart';
import 'package:new_project/services/auth/auth_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentuser;
      if (user == null) {
        emit(AuthStatLoggedOut(exception: null, isLoading: false));
      } else if (!user.isEmailVerified) {
        emit(AuthStatNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user,isLoading: false));
      }
    });
    on<AuthEventSendVerification>(((event, emit) {
      provider.sendEmailVerification();
      emit(state);
    }));

    on<AuthEventRegister>(((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(email: email, password: password);
        await provider.sendEmailVerification();
        emit(AuthStatNeedsVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    }));

    on<AuthEventLogin>((event, emit) async {
      emit(AuthStatLoggedOut(exception: null, isLoading: true, loadingtext: 'Logging In'));
      try {
        final user =
            await provider.login(email: event.email, password: event.password);

        if (!user.isEmailVerified) {
          emit(AuthStatLoggedOut(exception: null, isLoading: false));
          emit(AuthStatNeedsVerification(isLoading: false));
        } else {
          emit(AuthStatLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user,isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStatLoggedOut(exception: e, isLoading: false));
      }
    });
    on<AuthEventLogout>((event, emit) async {
      try {
        await provider.logout();
        emit(AuthStatLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStatLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
