part of 'auth_bloc.dart';

class AuthState extends Equatable {

  final LoadStatus status;
  final String? error;
  final User? currentUser;

  const AuthState({
    required this.status,
    this.error,
    this.currentUser,
  });

  const AuthState.initial() :this(status: LoadStatus.initial);

  const AuthState.loading() : this(status: LoadStatus.loading);

  const AuthState.success(User? user) :
        this(status: LoadStatus.success, currentUser: user);

  const AuthState.error(String error)
      : this(status: LoadStatus.error, error: error);

  const AuthState.networkError() : this(status: LoadStatus.networkError);

  @override
  List<Object?> get props => [status, currentUser];
}