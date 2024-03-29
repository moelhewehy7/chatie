import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chat/presentation/views/widgets/chat_card.dart';
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
          showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter friend email",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextForm(
                          controller: emailController,
                          hinttext: "Email",
                          icon: Icons.email,
                        )
                      ]),
                );
              });
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
            childCount: 16,
            (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ChatCard(),
              );
            },
          )),
        ],
      ),
    );
  }
}
