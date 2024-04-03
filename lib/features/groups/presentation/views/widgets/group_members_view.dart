import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_add_members.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class GroupMembersView extends StatefulWidget {
  const GroupMembersView({super.key});

  @override
  State<GroupMembersView> createState() => _GroupMembersViewState();
}

class _GroupMembersViewState extends State<GroupMembersView> {
  TextEditingController groupcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Done"),
        icon: const Icon(Icons.check_circle),
      ),
      appBar: AppBar(
        title: const Text("Group info"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GroupAddMembers()));
              },
              icon: const Icon(Icons.person_add_alt_1))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(radius: 45),
                    Positioned(
                        bottom: -10,
                        right: -10,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_a_photo)))
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextForm(
                        hinttext: "Group Name",
                        icon: IconlyBold.user_3,
                        controller: groupcontroller),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("Member $index"),
                    subtitle: const Text("Admin"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.admin_panel_settings)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.person_remove))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
