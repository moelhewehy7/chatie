import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 3),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  messageModel.message!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.surface),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(messageModel.createdAt!)),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface)),
                    const SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.done_all_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class ChatBubleFriend extends StatelessWidget {
  const ChatBubleFriend({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageModel.message!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  DateFormat('hh:mm a')
                      .format(DateTime.parse(messageModel.createdAt!)),
                )
              ],
            ),
          ),
        ));
  }
}
