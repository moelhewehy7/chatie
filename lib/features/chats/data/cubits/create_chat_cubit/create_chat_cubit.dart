import 'package:chatie/features/chats/data/create_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit() : super(CreateChatInitial());

  showmodalBottomSheet(
      BuildContext context, TextEditingController emailController) {
    emit(CreateChatLoading());
    try {
      Room().create(context: context, email: emailController.text);
      emit(CreateChatSuccess());
    } catch (e) {
      emit(CreateChatFailure(
          errMessage: "Oops! Something went wrong, Try again later."));
    }
  }
}
