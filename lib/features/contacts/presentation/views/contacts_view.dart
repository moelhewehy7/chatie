import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chats/presentation/views/widgets/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  bool searching = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomsheet(
              key: formKey,
              validator: (data) {},
              context: context,
              buttonName: "Add contact",
              onpressed: () {},
              emailController: emailController);
        },
        child: Icon(Icons.person_add_alt_1),
      ),
      appBar: AppBar(
        title: searching
            ? TextForm(
                autofocus: true,
                controller: contactController,
                hinttext: "Search by name",
                icon: Icons.search,
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                })
            : const Text("My contacts"),
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
              : IconButton(
                  padding: const EdgeInsets.only(right: 3),
                  onPressed: () {
                    searching = true;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.person_search,
                    size: 26,
                  ))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: const Text("Name"),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(IconlyBold.chat)),
            ),
          );
        },
      ),
    );
  }
}
