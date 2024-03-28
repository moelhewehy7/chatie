import 'package:chatie/features/chat/presentation/views/widgets/send_messeg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Name",
            ),
            Text("last seen today at 11:18",
                style: Theme.of(context).textTheme.labelMedium)
          ]),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.content_copy)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outlined,
                size: 28,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [Spacer(), SendMessege()],
        ),
      ),
    );
  }
}
