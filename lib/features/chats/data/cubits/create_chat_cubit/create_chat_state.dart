part of 'create_chat_cubit.dart';

@immutable
sealed class CreateChatState {}

final class CreateChatInitial extends CreateChatState {}

final class CreateChatLoading extends CreateChatState {}

final class CreateChatSuccess extends CreateChatState {}

final class CreateChatFailure extends CreateChatState {
  final String errMessage;
  CreateChatFailure({required this.errMessage});
}
