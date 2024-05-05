import 'package:chatie/features/chats/data/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_chats_state.dart';

class FetchChatsCubit extends Cubit<FetchChatsState> {
  FetchChatsCubit() : super(FetchChatsInitial());

  fetchChats({required String email}) {
    emit(FetchChatsLoading());
    FirebaseFirestore.instance
        .collection("rooms")
        .where("members", arrayContains: email)
        .snapshots()
        .listen((event) {
      List<ChatRoomModel> rooms = [];
      if (event.docs.isNotEmpty) {
        for (var doc in event.docs) {
          //we are converting the list of query snapshot to a list of chatroommodel
          rooms.add(ChatRoomModel.fromJson(doc));
        }
        emit(FetchChatsSuccess(rooms: rooms));
      } else {
        emit(FetchChatsEmpty());
      }
    });
  }
}
