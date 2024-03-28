import 'package:chatie/features/chat/presentation/views/widgets/chats_view_body.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatViewBody()));
        },
        leading: CircleAvatar(),
        title: Text("Name"),
        subtitle: Text("Last message"),
        trailing: Column(
          children: [
            Text("10:42 PM"),
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
