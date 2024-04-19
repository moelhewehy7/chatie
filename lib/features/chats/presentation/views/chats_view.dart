import 'package:chatie/features/chats/data/create_room.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomsheet(
            key: formKey,
            context: context,
            emailController: emailController,
            validator: (String? data) {
              if (data == null || data.isEmpty) {
                return 'Please enter an email';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(data)) {
                return 'Invalid email address.';
              }
              return null;
            },
            onpressed: () async {
              if (formKey.currentState!.validate()) {
                await Room()
                    .create(email: emailController.text)
                    .then((value) => Navigator.pop(context));
                emailController.clear();
              }
            },
            buttonName: "Create Chat",
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
