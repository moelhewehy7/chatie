import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<MessageModel> messages = [];
  Future sendMessage(
      {required String message,
      required String roomId,
      required String userEmail}) async {
    final myEmail = FirebaseAuth.instance.currentUser!.email;
    debugPrint("myEmail and useremail = $myEmail and $userEmail");
    String msgId = const Uuid()
        .v1(); //t will generate a new, unique UUID based on the current time and the MAC address of the device.
    await FirebaseFirestore.instance
        .collection("rooms")
        .doc(
            roomId) //so we can create messages in a specific room using the roomId
        .collection("messages")
        .doc(msgId)
        .set({
      "id": msgId,
      "fromId": myEmail,
      "toId": userEmail,
      "read": "",
      "type": "text",
      "message": message,
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  void getMessage({required String roomId}) {
    // messages.clear(); // Clear the messages list before fetching messages for the new chat
    try {
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((event) {
        messages
            .clear(); // to make sure to send just a new message not the whole list
        if (event.docs.isNotEmpty) {
          for (var doc in event.docs) {
            messages.add(MessageModel.fromjson(doc));
          }
          emit(ChatSuccess());
        } else {
          emit(ChatEmpty());
        }
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }
}
