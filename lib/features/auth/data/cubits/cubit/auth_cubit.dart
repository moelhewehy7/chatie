import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signUp(
      {required String email,
      required String bio,
      required String password,
      required String firstName,
      required String lastname}) async {
    emit(SignUpLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance.collection("users").doc(email).set({
        "Firstname": firstName,
        "Lastname": lastname,
        "Email": email,
        "image": "",
        "bio": bio,
        "myUsers": [],
        "JoinedOn": DateTime.now().millisecondsSinceEpoch.toString()
      });
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(errMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(
            errMessage: 'The account already exists for that email.'));
      } else {
        emit(SignUpFailure(
            errMessage: 'Oops, something went wrong. Please try again later.'));
      }
    } catch (e) {
      emit(SignUpFailure(
          errMessage: 'Oops, something went wrong. Please try again later.'));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(LogInLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LogInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LogInFailure(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
            LogInFailure(errMessage: 'Wrong password provided for that user.'));
      } else {
        emit(LogInFailure(
            errMessage: 'Oops, something went wrong. Please try again later.'));
      }
    } catch (e) {
      emit(LogInFailure(
          errMessage: 'Oops, something went wrong. Please try again later.'));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(ResetpasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetpasswordSuccess(
        errMessage:
            'A password reset email has been sent to $email. Please sign in again!',
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(Resetpasswordfailure(
          errMessage:
              'There is no user record corresponding to this email. Please check the email address.',
        ));
      } else {
        emit(Resetpasswordfailure(
          errMessage:
              'Failed to send password reset email. Please try again later.',
        ));
      }
    }
  }
}
