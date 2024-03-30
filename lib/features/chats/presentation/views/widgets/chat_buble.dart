import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key});

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
                  "wlasfasfsadjj asdasdasd dsad asda",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.surface),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("6:20 PM",
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
  const ChatBubleFriend({super.key});

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
                  "jMasdasd asdsad",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Text(
                  "6:20 PM",
                )
              ],
            ),
          ),
        ));
  }
}
