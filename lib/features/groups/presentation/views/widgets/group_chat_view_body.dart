import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_bubles.dart';
import 'package:chatie/features/groups/data/cubits/group_chats_cubit/group_chats_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_members_view.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_send_message_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class GroupChatViewBody extends StatefulWidget {
  const GroupChatViewBody({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupChatViewBody> createState() => _GroupChatViewBodyState();
}

class _GroupChatViewBodyState extends State<GroupChatViewBody> {
  List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.groupModel.name!,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("Email", whereIn: widget.groupModel.members)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List usersList = [];
                      for (var doc in snapshot.data!.docs) {
                        usersList.add(doc.data()[
                            "Firstname"]); //populating a list called usersList with the values of the "Firstname"
                      } //if we user list of usermodel it will be shown as instacne of usermodel
                      // because we need to loop againg and fetch the field that we want
                      return Text(usersList.join(", "),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium);
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.content_copy)),
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const GroupMembersView();
                  }));
                },
                icon: const Icon(
                  IconlyBold.user_3,
                  size: 26,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<GroupChatsCubit, GroupChatsState>(
                builder: (context, state) {
                  if (state is GroupChatsSuccess) {
                    messages =
                        BlocProvider.of<GroupChatsCubit>(context).messages;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (messages[index].fromId ==
                            FirebaseAuth.instance.currentUser!.email) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ChatBuble(
                                messageModel: messages[index],
                              )
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              GroupChatBubleFriend(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        }
                      },
                    );
                  } else if (state is GroupChatsEmpty) {
                    return Center(
                        child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<GroupChatsCubit>(context).sendMessage(
                          message: "asalam alaykum 👋",
                          groupId: widget.groupModel.id!,
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "👋",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text("Say asalam alaykum",
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ),
                      ),
                    ));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            GroupSendMessege(groupModel: widget.groupModel),
          ],
        ),
      ),
    );
  }
}
