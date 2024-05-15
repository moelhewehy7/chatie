import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/home/data/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({required this.userModel, super.key});
  final UserModel userModel;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstController.text = widget.userModel.firstName!;
    lastController.text = widget.userModel.lastName!;
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
          child: Form(
            key: formKey,
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
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              print(image.path);
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
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(IconlyBold.edit)),
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
                        FillButton(
                            onPressed: () {},
                            child: SpinKitFadingCircle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              size: 20.0,
                            ));
                      }
                      return FillButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<UserDataCubit>(context)
                                  .updateUserData(
                                      firstName: firstController.text,
                                      lastName: lastController.text,
                                      imageUrl: "imageUrl");
                            }
                          },
                          child: const Text("Save"));
                    },
                  ))
            ]),
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
