import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';

PersistentBottomSheetController showbottomsheet(
    {required BuildContext context,
    required TextEditingController emailController,
    required String? Function(String?)? validator,
    required void Function() onpressed,
    required String buttonName,
    required Key key}) {
  return showBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Form(
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
                Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: FillButton(
                      onPressed: onpressed,
                      child: Text(buttonName),
                    )),
              ],
            )
          ]),
        ),
      );
    },
  );
}
