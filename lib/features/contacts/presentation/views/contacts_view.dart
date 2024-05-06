import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chats/presentation/views/widgets/show_bottom_sheet.dart';
import 'package:chatie/features/contacts/data/cubits/add_contact_cubit/add_contact_cubit.dart';
import 'package:chatie/features/contacts/data/cubits/cubit/fetch_contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView>
    with AutomaticKeepAliveClientMixin {
  bool searching = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btn3",
        onPressed: () {
          showbottomsheet(
              widget: BlocProvider(
                create: (context) => AddContactCubit(),
                child: BlocConsumer<AddContactCubit, AddContactState>(
                  listener: (context, state) {
                    if (state is AddContactSuccess) {
                      Navigator.pop(context);
                    } else if (state is AddContactFailure) {
                      showAlert(context,
                          title: "Error",
                          content: state.errMessage,
                          buttonText: "Ok");
                    }
                  },
                  builder: (context, state) {
                    if (state is AddContactLoading) {
                      return FillButton(
                          onPressed: () {},
                          child: SpinKitFadingCircle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            size: 20.0,
                          ));
                    } else {
                      return FillButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AddContactCubit>(context)
                                  .add(email: emailController.text);
                              emailController.clear();
                            }
                          },
                          child: const Text("Add contact"));
                    }
                  },
                ),
              ),
              key: formKey,
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Please enter an email';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(data)) {
                  return 'Invalid email address.';
                }
                return null;
              },
              context: context,
              emailController: emailController);
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
      appBar: AppBar(
        titleSpacing: 5,
        title: searching
            ? Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextForm(
                    autofocus: true,
                    controller: contactController,
                    hinttext: "Search by name",
                    icon: Icons.search,
                    validator: (data) {
                      if (data == null || data.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    }),
              )
            : const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("My contacts"),
              ),
        actions: [
          searching
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                      onPressed: () {
                        searching = false;
                        setState(() {});
                      },
                      child: const Text(
                        "Cancel",
                      )),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: IconButton(
                      onPressed: () {
                        searching = true;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.person_search,
                        size: 26,
                      )),
                )
        ],
      ),
      body: BlocBuilder<FetchContactsCubit, FetchContactsState>(
        builder: (context, state) {
          if (state is FetchContactsSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: state.users.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Text(
                        "${state.users[index].firstName!} ${state.users[index].lastName!}"),
                    subtitle: Text(
                      state.users[index].bio!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(IconlyBold.chat)),
                  ),
                );
              },
            );
          } else if (state is FetchContactsEmpty) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
