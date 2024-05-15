part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataSuccess extends UserDataState {
  final UserModel userModel;
  UserDataSuccess({required this.userModel});
}

final class UserDataLoading extends UserDataState {}

final class UserDataUpdating extends UserDataState {}
