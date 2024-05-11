import 'package:chatie/features/chats/presentation/views/widgets/send_messeg.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_members_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class GroupChatViewBody extends StatelessWidget {
  const GroupChatViewBody({super.key, required this.groupModel});
  final GroupModel groupModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                groupModel.name!,
              ),
              Text(groupModel.members!.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium)
            ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.content_copy)),
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const GroupMembersView();
                  }));
                },
                icon: const Icon(
                  IconlyBold.user_3,
                  size: 26,
                )),
          ),
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
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // children: [ChatBuble()],
                  );
                },
              ),
            ),
            //  SendMessege(roomId: "",userModel:"" ,)
          ],
        ),
      ),
    );
  }
}
