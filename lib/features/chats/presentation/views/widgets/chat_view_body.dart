import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_bubles.dart';
import 'package:chatie/features/chats/presentation/views/widgets/profile_pic.dart';
import 'package:chatie/features/chats/presentation/views/widgets/send_messeg.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
        ),
        leadingWidth: MediaQuery.of(context).size.width * 0.08,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: ProfilePic(
                  radius: 20, doubleRadius: 40, userModel: widget.userModel),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  "${widget.userModel.firstName!} ${widget.userModel.lastName!}",
                  style: Theme.of(context).textTheme.titleMedium),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.userModel.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                          snapshot.data!.data()!["Online"] == true
                              ? "online"
                              : 'Last seen ${formatLastSeen(snapshot.data!.data()!["lastSeen"])}'
                                  .toLowerCase(),
                          style: Theme.of(context).textTheme.labelMedium);
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: selectedCopyMessage
                        .join('\n'))); //Converts each element to a [String]
                selectedMessage.clear();
                selectedCopyMessage.clear();
                setState(() {});
              },
              icon: selectedCopyMessage.isNotEmpty
                  ? const Icon(Icons.content_copy)
                  : const SizedBox()),
          IconButton(
              onPressed: () async {
                await FirebaseHelper().deleteMessage(
                    selectedMessage: selectedMessage, roomId: widget.roomId);
                selectedCopyMessage.clear();
                selectedMessage.clear();
                setState(() {});
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
                                  debugPrint(selectedCopyMessage.toString());
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
                                  debugPrint(selectedCopyMessage.toString());
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 3,
                                ),
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
                                  debugPrint(selectedCopyMessage.toString());
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
                                margin: const EdgeInsets.only(bottom: 3),
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
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(
                              userModel: widget.userModel,
                              context: context,
                              message: "asalam alaykum 👋",
                              roomId: widget.roomId,
                              userEmail: widget.userModel.email!)
                          .then((value) => FirebaseHelper().sendNotification(
                              context: context,
                              message: "image",
                              userModel: widget.userModel));
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
          SendMessege(roomId: widget.roomId, userModel: widget.userModel)
        ],
      ),
    );
  }

  String formatLastSeen(dynamic lastSeenTimestamp) {
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(lastSeenTimestamp.toString()));
      final now = DateTime.now();
      final difference = now.difference(dateTime).inDays; // Difference in days
      String formattedDay;

      if (difference == 0) {
        formattedDay = 'Today';
      } else if (difference == 1) {
        formattedDay = 'Yesterday';
      } else {
        formattedDay = DateFormat('EEEE').format(dateTime); // Day of the week
      }

      final formattedTime = DateFormat('hh:mm a').format(dateTime);
      return '$formattedDay at $formattedTime';
    } catch (e) {
      return 'Last seen: Unknown';
    }
  }
  // Text(
  //                 DateFormat('hh:mm a').format(
  //                     DateTime.fromMillisecondsSinceEpoch(
  //                         int.parse(widget.messageModel.createdAt!))),
  //               )
}

// 1-initialization: Two lists are initialized at the start of the widget's state:
// selectedMessage: Stores the IDs of selected messages.
// selectedCopyMessage: Stores the content of selected text messages.
// 2-Selection Logic:
// When a message is long-pressed, it toggles its selection status in selectedMessage and 
//  adds or removes its content in selectedCopyMessage if it's a text message.
// When a message is tapped, it toggles its selection status in selectedMessage.
// Selected messages are visually highlighted in the UI.
// 3-Action Buttons:
// The "Copy" button copies the content of all selected text messages to the clipboard and clears both selectedMessage and selectedCopyMessage.
// The "Delete" button deletes all selected messages by calling the deleteMessage method and then clears both selectedMessage and selectedCopyMessage.
// UI Updates: The setState method is used to update the UI whenever selectedMessage or selectedCopyMessage changes.