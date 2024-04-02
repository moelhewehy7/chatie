import 'package:chatie/features/chats/presentation/views/widgets/chat_card.dart';
import 'package:chatie/features/chats/presentation/views/widgets/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomsheet(context, emailController, "Create chat");
        },
        child: const Icon(
          Icons.maps_ugc,
          size: 27,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            elevation: 1,
            title: Text("Chatie"),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 4,
            (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ChatCard(
                  text: Text("Name"),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
