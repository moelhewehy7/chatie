import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/contacts/data/cubits/fetch_contacts_cubit/fetch_contacts_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/home/data/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroupAddMembers extends StatefulWidget {
  const GroupAddMembers({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupAddMembers> createState() => _GroupAddMembersState();
}

class _GroupAddMembersState extends State<GroupAddMembers> {
  List<UserModel> userModel = [];
  List addedMembers = [];

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: isLoading
            ? FloatingActionButton(
                onPressed: () {},
                child: SpinKitFadingCircle(
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20.0,
                ))
            : FloatingActionButton.extended(
                onPressed: () async {
                  setState(() {
                    isLoading =
                        true; // Set isLoading to true to show the spinner
                  });

                  // Simulate an asynchronous operation

                  await addMember(
                          groupId: widget.groupModel.id!, members: addedMembers)
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  });
                },
                label: const Text("Done"),
                icon: const Icon(Icons.check_circle),
              ),
        appBar: AppBar(
          title: const Text("Add Members"),
        ),
        body: BlocBuilder<FetchContactsCubit, FetchContactsState>(
          builder: (context, state) {
            if (state is FetchContactsSuccess) {
              userModel = state.users
                  .where((element) =>
                      !widget.groupModel.members!.contains(element.email))
                  .toList()
                ..sort((a, b) => a.firstName!.compareTo(b.firstName!));
              if (userModel.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: userModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      value: addedMembers.contains(userModel[index].email),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            addedMembers.add(userModel[index].email!);
                          } else {
                            addedMembers.remove(userModel[index].email!);
                          }
                        });
                      },
                      title: Text(
                          "${userModel[index].firstName} ${userModel[index].lastName}"),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No Users Found"),
                );
              }
            } else {
              return const SizedBox(); //CircularProgressIndicator();
            }
          },
        ));
  }
}
