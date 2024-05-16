import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/home/data/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({required this.userModel, super.key});
  final UserModel userModel;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseStorage fireStorage = FirebaseStorage.instance;
  final myEmail = FirebaseAuth.instance.currentUser!.email!;
  String _image = "";
  String imagePath = "";
  bool isUpdating = false;

  @override
  void initState() {
    firstController.text = widget.userModel.firstName!;
    lastController.text = widget.userModel.lastName!;
    bioController.text = widget.userModel.bio!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isUpdating,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: formKey,
              child: Column(children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: ClipOval(
                          child: CachedNetworkImage(
                        imageUrl: widget.userModel.profilePic! !=
                                FireStorage().alternativeImage
                            ? widget.userModel.profilePic!
                            : FireStorage().alternativeImage,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 60,
                          backgroundImage: imageProvider,
                        ),
                      )),
                    ),
                    Positioned(
                        right: -10,
                        bottom: -10,
                        child: IconButton(
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? image = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                if (!context.mounted) return;
                                showtoast(
                                    msg:
                                        "Profile picture is updating, please wait",
                                    context: context,
                                    time: 3);
                                imagePath = image.path;
                                String ext =
                                    File(image.path).path.split('.').last;
                                String fileName =
                                    "images/profilePics/$myEmail/${DateTime.now().microsecondsSinceEpoch}.$ext";
                                final ref = fireStorage.ref().child(fileName);
                                await ref.putFile(File(image.path));
                                _image = await ref.getDownloadURL();

                                setState(() {
                                  widget.userModel.profilePic = _image;
                                });
                              }
                            },
                            icon: const Icon(IconlyBold.edit)))
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(IconlyBold.profile),
                    title: ProfileField(
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Please enter your first name';
                        } else if (data.length > 8) {
                          return 'Last name must be at most 8 characters';
                        }
                        return null;
                      },
                      firstController: firstController,
                      hintText: 'First name',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(IconlyBold.profile),
                    title: ProfileField(
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Please enter your last name';
                        } else if (data.length > 8) {
                          return 'Last name must be at most 8 characters';
                        }
                        return null;
                      },
                      firstController: lastController,
                      hintText: 'Last name',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.self_improvement),
                    title: ProfileField(
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Field can\'t be empty';
                        }
                        return null;
                      },
                      firstController: bioController,
                      hintText: 'bio',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Card(
                  child: ListTile(
                    minVerticalPadding: 24,
                    leading: const Icon(IconlyBold.message),
                    title: Text(widget.userModel.email!),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text("Joined on"),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(widget.userModel.joinedOn!))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<UserDataCubit, UserDataState>(
                      builder: (context, state) {
                        if (state is UserDataLoading) {
                          return FillButton(
                              onPressed: () {},
                              child: SpinKitFadingCircle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                size: 20.0,
                              ));
                        } else {
                          return FillButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isUpdating = true;
                                });

                                // Check if the data are the same
                                if (firstController.text ==
                                        widget.userModel.firstName! &&
                                    lastController.text ==
                                        widget.userModel.lastName! &&
                                    bioController.text ==
                                        widget.userModel.bio! &&
                                    imagePath == "") {
                                  // Data are the same, do nothing
                                  Navigator.pop(context);
                                } else {
                                  showtoast(
                                      msg: "Updating profile, please wait",
                                      context: context,
                                      time: 2);
                                  await BlocProvider.of<UserDataCubit>(context)
                                      .updateUserData(
                                    firstName: firstController.text,
                                    lastName: lastController.text,
                                    bio: bioController.text,
                                    imageUrl: _image.isEmpty
                                        ? widget.userModel.profilePic!
                                        : _image,
                                  )
                                      .then((value) {
                                    setState(() {
                                      isUpdating = false;
                                    });
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            },
                            child: const Text("Save"),
                          );
                        }
                      },
                    ))
              ]),
            ),
          ),
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
    required this.validator,
  });
  final String? Function(String?)? validator;
  final TextEditingController firstController;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: firstController,
      decoration: InputDecoration(hintText: hintText, border: InputBorder.none),
    );
  }
}
