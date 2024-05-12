import 'package:chatie/features/groups/data/cubits/group_chats_cubit/group_chats_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_chat_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GroupChatCard extends StatelessWidget {
  const GroupChatCard({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        splashColor: Colors.transparent,
        onTap: () {
          context.read<GroupChatsCubit>().getMessage(groupId: groupModel.id!);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupChatViewBody(
                        groupModel: groupModel,
                      )));
        },
        leading: CircleAvatar(
            child: Text(groupModel.name!.characters.first.toUpperCase())),
        title: Text(
          groupModel.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          groupModel.lastMessage! != ""
              ? groupModel.lastMessage!
              : "Send your first message",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          children: [
            Text(DateFormat('h:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(int.parse(
                    groupModel.lastMessageTime != ""
                        ? groupModel.lastMessageTime!
                        : groupModel.createdAt!)))),
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
