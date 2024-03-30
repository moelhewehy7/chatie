import 'package:chatie/features/chats/presentation/views/widgets/chat_card.dart';
import 'package:chatie/features/groups/presentation/views/widgets/create_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroup()),
              );
            },
            child: const Icon(
              Icons.maps_ugc,
              size: 27,
            )),
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
                  child: ChatCard(
                    text: Text("Group name"),
                  ),
                );
              },
            )),
          ],
        ));
  }
}