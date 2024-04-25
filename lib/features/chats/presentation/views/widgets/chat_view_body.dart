import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_bubles.dart';
import 'package:chatie/features/chats/presentation/views/widgets/send_messeg.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody(
      {super.key, required this.roomId, required this.userModel});
  final String roomId;
  final UserModel userModel;

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  List<MessageModel> messages = [];

  List<String> selectedMessage = [];
  List<String> selectedCopyMessage = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.userModel.firstName!,
              style: Theme.of(context).textTheme.titleMedium),
          Text("last seen today at 11:18",
              style: Theme.of(context).textTheme.labelMedium)
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: selectedCopyMessage.isNotEmpty
                  ? const Icon(Icons.content_copy)
                  : const SizedBox()),
          IconButton(
              onPressed: () async {
                await deleteMessage(
                    selectedMessage: selectedMessage, roomId: widget.roomId);
                selectedMessage.clear();
              },
              icon: selectedMessage.isNotEmpty
                  ? const Icon(
                      Icons.delete_outlined,
                      size: 28,
                    )
                  : const SizedBox()),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatSuccess) {
                  messages = BlocProvider.of<ChatCubit>(context).messages;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return messages[index].fromId ==
                              FirebaseAuth.instance.currentUser!.email
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedMessage
                                      .isNotEmpty) // Check if there is any message selected to be unselected or selected
                                  {
                                    selectedMessage.contains(messages[index]
                                            .id) // Check if the selected message is already selected or not
                                        ? selectedMessage.remove(messages[index]
                                            .id) // if selected remove it
                                        : selectedMessage.add(messages[index]
                                            .id!); //if not add it
                                  }
                                  if (selectedCopyMessage.isNotEmpty &&
                                      messages[index].type == "text") {
                                    //to select just texts
                                    selectedCopyMessage
                                            .contains(messages[index].message)
                                        ? selectedCopyMessage
                                            .remove(messages[index].message)
                                        : selectedCopyMessage
                                            .add(messages[index].message!);
                                  }
                                });
                              },
                              onLongPress: () {
                                setState(() {
                                  selectedMessage.contains(messages[index]
                                          .id) // Check if the selected message is already selected or not
                                      ? selectedMessage.remove(messages[index]
                                          .id) // if selected remove it
                                      : selectedMessage.add(
                                          messages[index].id!); //if not add it}

                                  if (messages[index].type == "text") {
                                    //to select just texts
                                    selectedCopyMessage
                                            .contains(messages[index].message)
                                        ? selectedCopyMessage
                                            .remove(messages[index].message)
                                        : selectedCopyMessage
                                            .add(messages[index].message!);
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: selectedMessage
                                          .contains(messages[index].id)
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ChatBuble(
                                      messageModel: messages[index],
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedMessage.isNotEmpty) {
                                    selectedMessage.contains(messages[index]
                                            .id) // Check if the selected message is already selected or not
                                        ? selectedMessage.remove(messages[index]
                                            .id) // if selected remove it
                                        : selectedMessage.add(messages[index]
                                            .id!); //if not add it}
                                  }
                                  if (selectedCopyMessage.isNotEmpty &&
                                      messages[index].type == "text") {
                                    //to select just texts
                                    selectedCopyMessage
                                            .contains(messages[index].message)
                                        ? selectedCopyMessage
                                            .remove(messages[index].message)
                                        : selectedCopyMessage
                                            .add(messages[index].message!);
                                  }
                                });
                              },
                              onLongPress: () {
                                setState(() {
                                  selectedMessage.contains(messages[index]
                                          .id) // Check if the selected message is already selected or not
                                      ? selectedMessage.remove(messages[index]
                                          .id) // if selected remove it
                                      : selectedMessage.add(
                                          messages[index].id!); //if not add it}
                                  if (messages[index].type == "text") {
                                    //to select just texts
                                    selectedCopyMessage
                                            .contains(messages[index].message)
                                        ? selectedCopyMessage
                                            .remove(messages[index].message)
                                        : selectedCopyMessage
                                            .add(messages[index].message!);
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: selectedMessage
                                          .contains(messages[index].id)
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    ChatBubleFriend(
                                      messageModel: messages[index],
                                      roomId: widget.roomId,
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  );
                } else if (state is ChatEmpty) {
                  return Center(
                      child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                          message: "asalam alaykum 👋",
                          roomId: widget.roomId,
                          userEmail: widget.userModel.email!);
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
          Padding(
            padding:
                const EdgeInsets.only(bottom: 16, right: 10, left: 10, top: 5),
            child:
                SendMessege(roomId: widget.roomId, userModel: widget.userModel),
          )
        ],
      ),
    );
  }
}
