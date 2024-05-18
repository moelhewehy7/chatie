import 'dart:io';

import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/groups/data/cubits/group_chats_cubit/group_chats_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class GroupSendMessege extends StatefulWidget {
  const GroupSendMessege({
    super.key,
    required this.groupModel,
  });
  final GroupModel groupModel;

  @override
  State<GroupSendMessege> createState() => _GroupSendMessegeState();
}

class _GroupSendMessegeState extends State<GroupSendMessege> {
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
                                  FireStorage().sendGroupImage(context,
                                      groupId: widget.groupModel.id!,
                                      file: File(image.path));
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
                        BlocProvider.of<GroupChatsCubit>(context).sendMessage(
                            message: messageCon.text,
                            groupId: widget.groupModel.id!);
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
