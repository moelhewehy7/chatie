import 'dart:io';

import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class SendMessege extends StatefulWidget {
  const SendMessege({
    super.key,
    required this.roomId,
    required this.userModel,
  });
  final String roomId;
  final UserModel userModel;
  @override
  State<SendMessege> createState() => _SendMessegeState();
}

class _SendMessegeState extends State<SendMessege> {
  TextEditingController messageCon = TextEditingController();
  bool showemoji = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: () {
                    setState(() {
                      showemoji = false;
                    });
                  },
                  controller: messageCon,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      hintText: "Message",
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showemoji = !showemoji;
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              icon: const Icon(Icons.emoji_emotions)),
                          IconButton(
                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? image = await imagePicker.pickImage(
                                    imageQuality: 50,
                                    requestFullMetadata: false,
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  if (!context.mounted) return;
                                  FireStorage().sendImage(context,
                                      userEmail: widget.userModel.email!,
                                      file: File(image.path),
                                      roomId: widget.roomId);
                                }
                              },
                              icon: const Icon(Icons.collections))
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: IconButton.filled(
                    padding: const EdgeInsets.all(12),
                    onPressed: () async {
                      if (messageCon.text.isNotEmpty) {
                        BlocProvider.of<ChatCubit>(context).sendMessage(
                          message: messageCon.text,
                          roomId: widget.roomId,
                          userEmail: widget.userModel.email!,
                        );
                        messageCon.clear();
                      }
                    },
                    icon: const Icon(IconlyLight.send)),
              )
            ],
          ),
        ),
        if (showemoji) showEmoji(),
      ],
    );
  }

  Widget showEmoji() {
    return EmojiPicker(
      textEditingController: messageCon,
      config: Config(
          skinToneConfig: SkinToneConfig(
              dialogBackgroundColor: Theme.of(context).colorScheme.background),
          swapCategoryAndBottomBar: true,
          categoryViewConfig: CategoryViewConfig(
            indicatorColor: Theme.of(context).colorScheme.primary,
            iconColorSelected: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          height: 256,
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: Theme.of(context).colorScheme.background,
            columns: 9,
            emojiSizeMax: 28 * (Platform.isIOS ? 1.20 : 1.0),
          ),
          bottomActionBarConfig: BottomActionBarConfig(
            buttonColor: Theme.of(context).colorScheme.background,
            buttonIconColor: Theme.of(context).colorScheme.primary,
            enabled: true,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          searchViewConfig: SearchViewConfig(
            buttonIconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.background,
          )),
    );
  }
}
// // bottomActionBarConfig: BottomActionBarConfig(
// //             enabled: false,
// //             backgroundColor: Theme.of(context).colorScheme.surfaceTint),
//     searchViewConfig: SearchViewConfig(
//             backgroundColor: Theme.of(context).colorScheme.onPrimary),