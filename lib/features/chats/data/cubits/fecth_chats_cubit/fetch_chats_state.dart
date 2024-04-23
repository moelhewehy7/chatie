part of 'fetch_chats_cubit.dart';

@immutable
sealed class FetchChatsState {}

final class FetchChatsInitial extends FetchChatsState {}

final class FetchChatsLoading extends FetchChatsState {}

final class FetchChatsSuccess extends FetchChatsState {
  // final List<ChatRoomModel> rooms;
  // FetchChatsSuccess({required this.rooms});
}

final class FetchChatsFailure extends FetchChatsState {
  final String errMessage;
  FetchChatsFailure({required this.errMessage});
}
