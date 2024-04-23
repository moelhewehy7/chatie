import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/presentation/views/login_view.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/settings/presentation/views/widgets/profile_view.dart';
import 'package:chatie/features/settings/presentation/views/widgets/qr_code._view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            ListTile(
              minVerticalPadding: 20,
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Name"),
                  ),
                ],
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QrCodeView()));
                  },
                  icon: const Icon(IconlyBold.scan)),
            ),
            Card(
                child: ListTile(
              leading: const Icon(IconlyBold.profile),
              title: const Text("Profile"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProfileView();
                    }));
                  },
                  icon: const Icon(IconlyLight.arrow_right)),
            )),
            const SizedBox(
              height: 4,
            ),
            Card(
                child: ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: ColorPicker(onColorChanged: (value) {}),
                        ),
                      );
                    });
              },
              leading: const Icon(IconlyBold.category),
              title: const Text("Themes"),
            )),
            const SizedBox(
              height: 4,
            ),
            Card(
                child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark mode"),
              trailing: Switch(value: true, onChanged: (value) {}),
            )),
            const SizedBox(
              height: 4,
            ),
            Card(
                child: ListTile(
              title: const Text("Signout"),
              trailing: IconButton(
                  onPressed: () async {
                    await signOutDialog(context);
                  },
                  icon: const Icon(IconlyLight.logout)),
            ))
          ],
        ),
      ),
    );
  }
}
