import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/contacts/data/cubits/fetch_contacts_cubit/fetch_contacts_cubit.dart';
import 'package:chatie/features/groups/data/cubits/create_group_cubit/create_group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupcontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List members = [];
  List contacts = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        floatingActionButton: BlocBuilder<CreateGroupCubit, CreateGroupState>(
          builder: (context, state) {
            if (state is CreateGroupLoading) {
              return FloatingActionButton(
                onPressed: () {},
                child: SpinKitFadingCircle(
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20.0,
                ),
              );
            } else {
              return members.isNotEmpty
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<CreateGroupCubit>(context)
                              .createGroup(
                                  groupName: groupcontroller.text,
                                  members: members)
                              .then((value) {
                            Navigator.pop(context);
                            members.clear();
                          });
                        }
                      },
                      label: const Text("Done"),
                      icon: const Icon(Icons.check_circle),
                    )
                  : const SizedBox();
            }
          },
        ),
        appBar: AppBar(title: const Text("Create Group")),
        body: Padding(
          padding: const EdgeInsets.all(16),
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
                          validator: (data) {
                            if (data!.isEmpty) {
                              return "Group name is required";
                            }
                            return null;
                          },
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
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Members"),
                  Text(members.length.toString())
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: BlocBuilder<FetchContactsCubit, FetchContactsState>(
                  builder: (context, state) {
                    if (state is FetchContactsSuccess) {
                      contacts = state.users;
                      return ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                            checkboxShape: const CircleBorder(),
                            value: members.contains(contacts[index]
                                .email!), //to check if the member is already added
                            onChanged: (value) {
                              if (value == true) {
                                //if marked as true
                                members.add(contacts[index].email!);
                              } else {
                                members.remove(contacts[index].email!);
                              }
                              setState(() {});
                            },
                            title: Text(
                                "${contacts[index].firstName!} ${contacts[index].lastName!}"),
                          );
                        },
                      );
                    } else if (state is FetchContactsEmpty) {
                      return const Center(
                        child: Text("No Contacts, Add Some"),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
