part of 'fetch_contacts_cubit.dart';

@immutable
sealed class FetchContactsState {}

final class FetchContactsInitial extends FetchContactsState {}

final class FetchContactsLoading extends FetchContactsState {}

final class FetchContactsEmpty extends FetchContactsState {
  final String message;
  FetchContactsEmpty({required this.message});
}

final class FetchContactsSuccess extends FetchContactsState {
  final UserModel userModel;
  FetchContactsSuccess({required this.userModel});
}
