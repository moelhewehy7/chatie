import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

PersistentBottomSheetController showbottomsheet(
    {required BuildContext context,
    required TextEditingController emailController,
    required String? Function(String?)? validator,
    required Key key,
    required Widget widget}) {
  return showBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Form(
          //check below
          key: key,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    "Enter friend email",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton.filled(
                      onPressed: () {}, icon: const Icon(IconlyBold.scan))
                ],
              ),
            ),
            TextForm(
              controller: emailController,
              validator: validator,
              hinttext: "Email",
              icon: Icons.email,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: const EdgeInsets.only(top: 12), child: widget),
              ],
            )
          ]),
        ),
      );
    },
  );
}
//the Form needs to be a direct child of the Scaffold for the Form to work properly.