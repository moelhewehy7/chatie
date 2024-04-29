import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/chats/data/models/chat_room_model.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_view_body.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chatRoom,
  });

  final ChatRoomModel chatRoom;
  @override
  Widget build(BuildContext context) {
    String userEmail = chatRoom.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.email)
        .first;
    debugPrint(
        "FirebaseAuth.instance.currentUser!.email   = ${FirebaseAuth.instance.currentUser!.email}");
    debugPrint(
        "userEmail chatRoom.members! = $userEmail"); // to get useremail from memebers list
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromjson(snapshot.data!.data());
            //convert single document to model
            return Card(
              child: ListTile(
                splashColor: Colors.transparent,
                onTap: () async {
                  context.read<ChatCubit>().getMessage(roomId: chatRoom.id!);
                  // BlocProvider.of<ChatCubit>(context)
                  //     .getMessage(roomId: chatRoom.id!);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatViewBody(
                                userModel: userModel,
                                roomId: chatRoom.id!,
                              )));
                },
                leading: const CircleAvatar(),
                title: Text("${userModel.firstName!} ${userModel.lastName!}"),
                subtitle: Text(
                  chatRoom.lastMessage != "lastMessage"
                      ? chatRoom.lastMessage!
                      : userModel.bio!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: Column(
                  children: [
                    Text(DateFormat('h:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(int.parse(
                            chatRoom.lasteMessageTime != ""
                                ? chatRoom.lasteMessageTime!
                                : chatRoom.createdAt!)))),
                    const SizedBox(
                      height: 3,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("rooms")
                            .doc(chatRoom.id)
                            .collection("messages")
                            .snapshots(),
                        builder: (context, snapshot) {
                          final List<MessageModel> unReadList = snapshot
                                  .data?.docs
                                  .map((e) => MessageModel.fromjson(e.data()))
                                  .where((element) => element.read == "")
                                  .where((element) =>
                                      element.fromId !=
                                      FirebaseAuth.instance.currentUser!.email)
                                  .toList() ??
                              []; //to get unRead messages for the other user
                          return unReadList.isNotEmpty
                              ? Badge(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  largeSize: 25,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  label: Text(
                                    unReadList.length.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                                  ),
                                )
                              : const SizedBox();
                        })
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
} // to get unRead messages
                          