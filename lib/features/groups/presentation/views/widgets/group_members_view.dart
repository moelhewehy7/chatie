import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chats/presentation/views/widgets/profile_pic.dart';
import 'package:chatie/features/contacts/data/cubits/fetch_contacts_cubit/fetch_contacts_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_add_members.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    bool isAdmin = widget.groupModel.admins!
        .contains(FirebaseAuth.instance.currentUser!.email);
    String myEmail = FirebaseAuth.instance.currentUser!.email!;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await editGroup(
            groupId: widget.groupModel.id!,
            name: groupcontroller.text,
          ).then((value) => setState(() {
                widget.groupModel.name = groupcontroller.text;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }));
        },
        label: const Text("Done"),
        icon: const Icon(Icons.check_circle),
      ),
      appBar: AppBar(
        title: const Text("Group info"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
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
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
          ListTile(
            onTap: () async {
              BlocProvider.of<FetchContactsCubit>(context).fetchContacts();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GroupAddMembers(
                        groupModel: widget.groupModel,
                      )));
            },
            contentPadding: const EdgeInsets.only(left: 19),
            leading: IconButton.filledTonal(
                padding: const EdgeInsets.all(9),
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupAddMembers(
                            groupModel: widget.groupModel,
                          )));
                },
                icon: const Icon(
                  Icons.person_add_alt_1,
                  size: 22,
                )),
            title: const Text("Add members"),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("Email",
                        whereIn: widget.groupModel
                            .members) //etrieve documents  where the "Email" field matches any of the values
                    .snapshots(), //
                // In summary, equal to is used for single condition filters, while whereIn is used for filters with multiple values.
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserModel> members = snapshot.data!.docs
                        .map((e) => UserModel.fromjson(e))
                        .toList();

                    return ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool selectedUserIsAdmin = widget.groupModel.admins!
                            .contains(members[index].email);
                        return ListTile(
                          onTap: () {},
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 24),
                          leading: ProfilePic(
                            userModel: members[index],
                            radius: 20,
                            doubleRadius: 40,
                          ),
                          title: Text(
                              "${members[index].firstName!} ${members[index].lastName!}"),
                          subtitle: selectedUserIsAdmin
                              ? const Text(
                                  "Admin",
                                  style: TextStyle(color: Colors.blue),
                                )
                              : const Text("Member"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isAdmin && myEmail == members[index].email
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        selectedUserIsAdmin // if the selected user is an admin
                                            ? removeAdimn(
                                                    groupId:
                                                        widget.groupModel.id!,
                                                    memberId:
                                                        members[index].email!)
                                                .then((value) => setState(() {
                                                      widget.groupModel.admins!
                                                          .remove(members[index]
                                                              .email!);
                                                    }))
                                            : promptAdmin(
                                                    groupId:
                                                        widget.groupModel.id!,
                                                    memberId:
                                                        members[index].email!)
                                                .then((value) => setState(() {
                                                      widget.groupModel.admins!
                                                          .add(members[index]
                                                              .email!);
                                                    }));
                                      },
                                      icon: isAdmin
                                          ? const Icon(
                                              Icons.admin_panel_settings)
                                          : const SizedBox()),
                              isAdmin && myEmail == members[index].email
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () async {
                                        await removeMember(
                                                groupId: widget.groupModel.id!,
                                                member: members[index].email!)
                                            .then((value) => setState(() {
                                                  widget.groupModel.members!
                                                      .remove(members[index]
                                                          .email!);
                                                }));
                                      },
                                      icon: isAdmin
                                          ? const Icon(Icons.person_remove)
                                          : const SizedBox())
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
