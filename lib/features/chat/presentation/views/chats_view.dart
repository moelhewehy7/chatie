import 'package:chatie/features/chat/presentation/views/widgets/chat_card.dart';
import 'package:chatie/features/chat/presentation/views/widgets/chats_view_body.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.maps_ugc,
          size: 27,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 1,
            title: Text("Chatie"),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 16,
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ChatCard(),
              );
            },
          )),
        ],
      ),
    );
  }
}
