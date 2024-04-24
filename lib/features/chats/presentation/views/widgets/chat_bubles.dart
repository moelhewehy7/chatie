import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
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
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 5),
          child: Container(
            constraints: BoxConstraints(maxWidth: width / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  child: messageModel.type == "image"
                      ? Container(
                          height: height * 0.35,
                          width: width * 0.5,
                          padding: EdgeInsets.only(bottom: 3),
                          child: SizedBox(
                            height: height * 0.35,
                            width: width * 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: messageModel.message!,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: const Color(0xFFE0E0E0),
                                  highlightColor: const Color(0xFFF5F5F5),
                                  child: Container(
                                    width: double.infinity,
                                    height:
                                        200.0, // Adjust the height as needed
                                    color: Colors.grey,
                                  ),
                                ),
                                errorWidget: (context, url, error) => SizedBox(
                                    height: height * 0.25,
                                    width: width * 0.2,
                                    child: Center(child: Icon(Icons.error))),
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
