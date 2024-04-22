import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class SendMessege extends StatefulWidget {
  const SendMessege({
    super.key,
    required this.roomId,
    required this.userModel,
  });
  final String roomId;
  final UserModel userModel;
  @override
  State<SendMessege> createState() => _SendMessegeState();
}

class _SendMessegeState extends State<SendMessege> {
  TextEditingController messageCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: TextField(
              controller: messageCon,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  hintText: "Message",
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(IconlyBold.camera))
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: IconButton.filled(
              padding: const EdgeInsets.all(12),
              onPressed: () async {
                if (messageCon.text.isNotEmpty) {
                  await BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: messageCon.text,
                      roomId: widget.roomId,
                      userEmail: widget.userModel.email!);

                  messageCon.clear();
                }
              },
              icon: const Icon(IconlyLight.send)),
        )
      ],
    );
  }
}
