import 'package:chatie/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chats/presentation/views/widgets/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomsheet(context, emailController, "Add contact");
        },
        child: const Icon(
          Icons.person_add_alt_1,
          size: 26,
        ),
      ),
      appBar: AppBar(
        title: searching
            ? TextForm(
                autofocus: true,
                controller: contactController,
                hinttext: "Search by name",
                icon: Icons.search,
                validator: (value) {},
              )
            : Text("Contacts"),
        actions: [
          searching
              ? Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: TextButton(
                      onPressed: () {
                        searching = false;
                        setState(() {});
                      },
                      child: Text(
                        "Cancel",
                      )),
                )
              : IconButton(
                  padding: EdgeInsets.only(right: 3),
                  onPressed: () {
                    searching = true;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.person_search,
                    size: 26,
                  ))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text("Name"),
              trailing:
                  IconButton(onPressed: () {}, icon: Icon(IconlyBold.chat)),
            ),
          );
        },
      ),
    );
  }
}
