import 'package:chatie/features/chats/presentation/views/widgets/chats_view_body.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.text,
  });
  final Text text;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatViewBody()));
        },
        leading: const CircleAvatar(),
        title: text,
        subtitle: const Text("Last message"),
        trailing: Column(
          children: [
            const Text("10:42 PM"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Badge(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                smallSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
