import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final myEmail = FirebaseAuth.instance.currentUser!.email;
  List<MessageModel> messages = [];
  Future sendMessage(
      {required String message,
      required String roomId,
      required String userEmail}) async {
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
    // Emit a loading state
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      messages.clear();
      if (event.docs.isNotEmpty) {
        // Check if there are documents
        for (var doc in event.docs) {
          messages.add(MessageModel.fromjson(doc));
        }

        emit(ChatSuccess()); // Emit success state after fetching messages
      }
    });
  }
}
