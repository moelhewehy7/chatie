part of 'group_chats_cubit.dart';

@immutable
sealed class GroupChatsState {}

final class GroupChatsInitial extends GroupChatsState {}

final class GroupChatsLoading extends GroupChatsState {}

final class GroupChatsSuccess extends GroupChatsState {}

final class GroupChatsEmpty extends GroupChatsState {}
