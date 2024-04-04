import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    // await Future.delayed(const Duration(seconds: 2));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure('The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(AuthFailure('Invalid email address.'));
      }
    } catch (e) {
      emit(AuthFailure('Oops , there is an error please try again later'));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());
    // await Future.delayed(const Duration(seconds: 2));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        emit(AuthFailure('Invalid email address.'));
      }
    } catch (e) {
      emit(AuthFailure('Oops , there is an error please try again later'));
    }
  }
}
