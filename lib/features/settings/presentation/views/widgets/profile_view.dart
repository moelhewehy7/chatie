import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  @override
  void initState() {
    firstController.text = "mohamed";
    lastController.text = "mohamed";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(IconlyBold.edit)))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Card(
              child: ListTile(
                leading: const Icon(IconlyBold.profile),
                title: ProfileField(
                  firstController: firstController,
                  hintText: 'First name',
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(IconlyBold.edit)),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Card(
              child: ListTile(
                leading: const Icon(IconlyBold.profile),
                title: ProfileField(
                  firstController: lastController,
                  hintText: 'Last name',
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(IconlyBold.edit)),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Card(
              child: ListTile(
                minVerticalPadding: 24,
                leading: Icon(IconlyBold.message),
                title: Text("Email"),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.date_range),
                title: Text("Joined on"),
                subtitle: Text("21/11/2022"),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                child: FillButton(onPressed: () {}, child: const Text("Save")))
          ]),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.firstController,
    required this.hintText,
  });

  final TextEditingController firstController;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstController,
      decoration: InputDecoration(hintText: hintText, border: InputBorder.none),
    );
  }
}
