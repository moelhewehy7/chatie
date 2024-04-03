import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

PersistentBottomSheetController showbottomsheet(
    BuildContext context, TextEditingController emailController, String text) {
  return showBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
            hinttext: "Email",
            icon: Icons.email,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: FillButton(onPressed: () {}, text: text),
              ),
            ],
          )
        ]),
      );
    },
  );
}
