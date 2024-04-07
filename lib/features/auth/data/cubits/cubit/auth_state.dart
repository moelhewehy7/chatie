part of 'auth_cubit.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  final String errMessage;
  SignUpFailure({required this.errMessage});
}

class LogInLoading extends AuthState {}

class LogInSuccess extends AuthState {}

class LogInFailure extends AuthState {
  final String errMessage;
  LogInFailure({required this.errMessage});
}

class ResetpasswordLoading extends AuthState {}

class ResetpasswordSuccess extends AuthState {
  final String errMessage;

  ResetpasswordSuccess({required this.errMessage});
}

class Resetpasswordfailure extends AuthState {
  final String errMessage;

  Resetpasswordfailure({required this.errMessage});
}
