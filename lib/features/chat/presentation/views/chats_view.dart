import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chat/presentation/views/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          "Enter friend email",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Spacer(),
                        IconButton.filled(
                            onPressed: () {}, icon: Icon(IconlyBold.scan))
                      ],
                    ),
                  ),
                  TextForm(
                    controller: emailController,
                    hinttext: "Email",
                    icon: Icons.email,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child:
                            FillButton(onPressed: () {}, text: "Create chat"),
                      ),
                    ],
                  )
                ]),
              );
            },
          );
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
            childCount: 3,
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
