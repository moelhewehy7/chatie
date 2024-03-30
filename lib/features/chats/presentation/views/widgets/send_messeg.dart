import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SendMessege extends StatelessWidget {
  const SendMessege({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: TextField(
              maxLines: 5,
              minLines: 1,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  hintText: "Message",
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(IconlyBold.camera))
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: IconButton.filled(
              padding: const EdgeInsets.all(12),
              onPressed: () {},
              icon: const Icon(IconlyLight.send)),
        )
      ],
    );
  }
}
