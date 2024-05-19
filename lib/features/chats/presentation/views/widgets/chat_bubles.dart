import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.messageModel,
  });
  final MessageModel messageModel;

  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Container(
            constraints: BoxConstraints(maxWidth: width / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2, left: 2),
                  child: messageModel.type == "image"
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          padding: const EdgeInsets.only(bottom: 3),
                          child: SizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: messageModel.message!,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  highlightColor: const Color(0xFFEEEEEE),
                                  child: Container(
                                    width: double.infinity,
                                    height: 300, // Adjust the height as needed
                                    color: Colors.grey[200],
                                  ),
                                ),
                                errorWidget: (context, url, error) => SizedBox(
                                    height: height * 0.25,
                                    width: width * 0.2,
                                    child:
                                        const Center(child: Icon(Icons.error))),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          messageModel.message!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.surface),
                        ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        DateFormat('hh:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageModel.createdAt!))),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface)),
                    const SizedBox(
                      width: 3,
                    ),
                    Icon(
                      messageModel.read == "" ? Icons.done : Icons.done_all,
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

class GroupChatBubleFriend extends StatelessWidget {
  const GroupChatBubleFriend({
    super.key,
    required this.messageModel,
  });
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(messageModel.fromId!.split("@")[0],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                messageModel.type == "image"
                    ? Container(
                        width: double.infinity,
                        height: 300,
                        padding: const EdgeInsets.only(bottom: 3),
                        child: SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: messageModel.message!,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                highlightColor: const Color(0xFFEEEEEE),
                                child: Container(
                                  width: double.infinity,
                                  height: 300, // Adjust the height as needed
                                  color: Colors.grey[200],
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                  height: height * 0.25,
                                  width: width * 0.2,
                                  child:
                                      const Center(child: Icon(Icons.error))),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        messageModel.message!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                Text(
                  DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(messageModel.createdAt!))),
                )
              ],
            ),
          ),
        ));
  }
}

class ChatBubleFriend extends StatefulWidget {
  const ChatBubleFriend({
    super.key,
    required this.messageModel,
    required this.roomId,
  });
  final MessageModel messageModel;
  final String roomId;

  @override
  State<ChatBubleFriend> createState() => _ChatBubleFriendState();
}

class _ChatBubleFriendState extends State<ChatBubleFriend> {
  @override
  void initState() {
    if (widget.messageModel.toId == FirebaseAuth.instance.currentUser!.email) {
      readMessage(msgId: widget.messageModel.id!, roomId: widget.roomId);
    } //if message toId == current user email we mark the message as read
    // so when the other user open th chat it will be showing read
    super.initState();
  }

  // the initState method in the ChatBubleFriend widget is used to p
  //marke the message as read when the widget is first displayed,
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.messageModel.type == "image"
                    ? Container(
                        width: double.infinity,
                        height: 300,
                        padding: const EdgeInsets.only(bottom: 3),
                        child: SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: widget.messageModel.message!,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                highlightColor: const Color(0xFFEEEEEE),
                                child: Container(
                                  width: double.infinity,
                                  height: 300, // Adjust the height as needed
                                  color: Colors.grey[200],
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                  height: height * 0.25,
                                  width: width * 0.2,
                                  child:
                                      const Center(child: Icon(Icons.error))),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        widget.messageModel.message!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                Text(
                  DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(widget.messageModel.createdAt!))),
                )
              ],
            ),
          ),
        ));
  }
}
