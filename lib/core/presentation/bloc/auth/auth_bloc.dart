import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../enums/load_status.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEventLogin>(_mapLoginEventToState);
  }

  Stream<AuthState> _mapLoginEventToState(
      AuthEventLogin event, Emitter<AuthState> emit) async* {
    emit(const AuthState.loading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthState.success(userCredential.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthState.error('Aucun utilisateur trouvé pour cet email.'));
      } else if (e.code == 'wrong-password') {
        emit(const AuthState.error('Mot de passe incorrect.'));
      } else {
        emit(const AuthState.error('Une erreur est survenue.'));
      }
    } catch (e) {
      emit(const AuthState.networkError());
    }
  }
}