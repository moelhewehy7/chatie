import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_add_members.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class GroupMembersView extends StatefulWidget {
  const GroupMembersView(
      {super.key, required this.initialValue, required this.groupModel});
  final String? initialValue;
  final GroupModel groupModel;
  @override
  State<GroupMembersView> createState() => _GroupMembersViewState();
}

class _GroupMembersViewState extends State<GroupMembersView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController groupcontroller =
        TextEditingController(text: widget.initialValue);

    bool isadmin = widget.groupModel.admins!
        .contains(FirebaseAuth.instance.currentUser!.email);
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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("Email", isEqualTo: widget.groupModel.members)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: widget.groupModel.members!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("Member $index"),
                            subtitle: const Text("Admin"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: isadmin
                                        ? const Icon(Icons.admin_panel_settings)
                                        : SizedBox()),
                                IconButton(
                                    onPressed: () {},
                                    icon: isadmin
                                        ? const Icon(Icons.person_remove)
                                        : SizedBox()),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
