import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'group_chats_state.dart';

class GroupChatsCubit extends Cubit<GroupChatsState> {
  GroupChatsCubit() : super(GroupChatsInitial());
  List<MessageModel> messages = [];
  Future sendMessage(
      {required String message,
      String? type,
      required String groupId,
      required BuildContext context,
      required GroupModel groupModel}) async {
    List<UserModel> users = [];
    List members = groupModel.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.email)
        .toList();
    FirebaseFirestore.instance
        .collection("users")
        .where("email", whereIn: members)
        .get()
        .then((value) {
      users.addAll(value.docs.map((e) => UserModel.fromjson(e)));
    });
    final myEmail = FirebaseAuth.instance.currentUser!.email;
    String gmsgId = const Uuid()
        .v1(); //t will generate a new, unique UUID based on the current time and the MAC address of the device.
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(gmsgId)
        .set({
      "id": gmsgId,
      "fromId": myEmail,
      "toId": "",
      "read": "",
      "message": message,
      "type": type ?? "text",
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
    }).then((value) {
      for (UserModel user in users) {
        FirebaseHelper().sendNotification(
            groupname: groupModel.name,
            message: message,
            context: context,
            userModel: user);
        print("done");
      }
    });
    users.clear();
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update({
      "lastMessage": type ?? message,
      "lasteMessageTime": DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  getMessage({required String groupId}) async {
    messages.clear();
    FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((event) {
      messages.clear();

      if (event.docs.isNotEmpty) {
        for (var doc in event.docs) {
          messages.add(MessageModel.fromjson(doc));
        }

        emit(GroupChatsSuccess());
      } else {
        emit(GroupChatsEmpty());
      }
    });
  }
}
