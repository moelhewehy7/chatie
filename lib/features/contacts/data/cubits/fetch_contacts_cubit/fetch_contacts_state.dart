part of 'fetch_contacts_cubit.dart';

@immutable
sealed class FetchContactsState {}

final class FetchContactsInitial extends FetchContactsState {}

final class FetchContactsLoading extends FetchContactsState {}

final class FetchContactsEmpty extends FetchContactsState {
  final String message;
  FetchContactsEmpty({required this.message});
}

final class FetchContactsFailure extends FetchContactsState {
  final String errMessage;
  FetchContactsFailure({required this.errMessage});
}

final class FetchContactsSuccess extends FetchContactsState {
  final List<UserModel> users;
  FetchContactsSuccess({required this.users});
}
