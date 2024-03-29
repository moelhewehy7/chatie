import 'package:chatie/features/chat/presentation/views/widgets/chat_buble.dart';
import 'package:chatie/features/chat/presentation/views/widgets/send_messeg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Name", style: Theme.of(context).textTheme.titleMedium),
          Text("last seen today at 11:18",
              style: Theme.of(context).textTheme.labelMedium)
        ]),
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
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ChatBuble()],
                  );
                },
              ),
            ),
            SendMessege()
          ],
        ),
      ),
    );
  }
}
