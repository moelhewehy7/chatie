import 'package:chatie/features/chats/data/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_chats_state.dart';

class FetchChatsCubit extends Cubit<FetchChatsState> {
  FetchChatsCubit() : super(FetchChatsInitial());

  fetchChats() {
    emit(FetchChatsLoading());
    FirebaseFirestore.instance
        .collection("rooms")
        .where("members",
            arrayContains: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((event) {
      List<ChatRoomModel> rooms = [];
      for (var doc in event.docs) {
        rooms.add(ChatRoomModel.fromJson(doc.data()));
      }
      emit(FetchChatsSuccess(rooms: rooms));
    });
  }
}
