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
          IconButton(onPressed: () {}, icon: const Icon(Icons.content_copy)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outlined,
                size: 28,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  debugPrint(
                      "messages[index].fromId  FirebaseAuth.instance.currentUser!.email = ${FirebaseAuth.instance.currentUser!.email}");
                  if (state is ChatSuccess) {
                    messages = BlocProvider.of<ChatCubit>(context).messages;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return messages[index].fromId ==
                                FirebaseAuth.instance.currentUser!.email
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ChatBuble(
                                    messageModel: messages[index],
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ChatBubleFriend(
                                    messageModel: messages[index],
                                    roomId: widget.roomId,
                                  )
                                ],
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
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "👋",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(
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
      ),
    );
  }
}
