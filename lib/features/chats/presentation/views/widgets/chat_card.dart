import 'package:chatie/features/chats/data/models/chat_room_model.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.text,
    required this.chatRoom,
  });
  final Text text;
  final ChatRoomModel chatRoom;
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
        title: Text(chatRoom.id ?? 'Friend'),
        subtitle: const Text("Last message"),
        trailing: Column(
          children: [
            Text(DateFormat('h:mm a')
                .format(DateTime.parse(chatRoom.createdAt ?? ""))),
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
