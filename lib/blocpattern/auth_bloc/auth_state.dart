import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'Authenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'Loading';
}
