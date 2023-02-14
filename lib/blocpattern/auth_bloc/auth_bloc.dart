import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/repositories/repositories.dart';
import 'auth.dart';
import 'package:flutter/material.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepositories userRepositories;
  AuthenticationBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(Key as AuthenticationState);

  AuthenticationState get initialState => AuthenticationUninitialized();

  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepositories.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepositories.persisteToken(event.token);
      yield AuthenticationAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepositories.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
