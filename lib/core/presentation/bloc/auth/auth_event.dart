part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin({required this.email, required this.password});
}

class AuthEventSubscribe extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String? phone;

  AuthEventSubscribe({
    required this.name,
    required this.password,
    required this.email,
    this.phone
  });
}