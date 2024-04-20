import 'package:chatie/features/chats/data/models/chat_room_model.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_view_body.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.text,
    required this.chatRoom,
  });
  final Text text;
  final ChatRoomModel chatRoom;
  @override
  Widget build(BuildContext context) {
    String userEmail = chatRoom.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.email)
        .first; // to get useremail from memebers list
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromjson(snapshot.data!.data());
            return Card(
              child: ListTile(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatViewBody(
                                userName: userModel.firstName!,
                                roomId: chatRoom.id!,
                              )));
                },
                leading: const CircleAvatar(),
                title: Text(userModel.firstName ?? 'Friend'),
                subtitle: Text(chatRoom.lastMessage != "lastMessage"
                    ? chatRoom.lastMessage!
                    : userModel.bio!),
                trailing: Column(
                  children: [
                    Text(DateFormat('h:mm a')
                        .format(DateTime.parse(chatRoom.createdAt ?? ""))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Badge(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        smallSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
