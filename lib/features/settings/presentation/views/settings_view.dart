import 'package:chatie/core/helper.dart';
import 'package:chatie/features/chats/presentation/views/widgets/profile_pic.dart';
import 'package:chatie/features/home/data/cubits/theme_cubit/theme_cubit.dart';
import 'package:chatie/features/home/data/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:chatie/features/settings/presentation/views/widgets/profile_view.dart';
import 'package:chatie/features/settings/presentation/views/widgets/qr_code._view.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  UserModel? userModel;

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
              title: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  if (state is UserDataSuccess) {
                    userModel = state.userModel;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfilePic(
                            userModel: userModel!,
                            radius: 40,
                            doubleRadius: 80),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                              "${userModel!.firstName!} ${userModel!.lastName!}"),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 100,
                              height: 20,
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
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
            const SizedBox(
              height: 20,
            ),
            Card(
                child: ListTile(
              leading: const Icon(IconlyBold.profile),
              title: const Text("Profile"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfileView(
                        userModel: userModel!,
                      );
                    }));
                  },
                  icon: const Icon(IconlyLight.arrow_right)),
            )),
            const SizedBox(
              height: 10,
            ),
            Card(
                child: ListTile(
              onTap: () async {
                final sharedprefs = await SharedPreferences.getInstance();
                if (!context.mounted) return;
                showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: ColorPicker(
                              color: Color(sharedprefs.getInt("color") ??
                                  Colors.indigo.value),
                              selectedPickerTypeColor: Color(
                                  sharedprefs.getInt("color") ??
                                      Colors.indigo.value),
                              onColorChanged: (value) {
                                context.read<ThemeCubit>().setColor(
                                    value.value.toRadixString(16).toColor);
                              }),
                        ),
                      );
                    });
              },
              leading: const Icon(IconlyBold.category),
              title: const Text("Themes"),
            )),
            const SizedBox(
              height: 10,
            ),
            Card(
                child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark mode"),
              trailing: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Switch(
                    value: state
                        is DarkThemeState, //so switch wull be off when we press it it will turn dark
                    onChanged: (value) {
                      context
                          .read<ThemeCubit>()
                          .toggleTheme(); // Call toggleTheme on press
                    },
                  );
                },
              ),
            )),
            const SizedBox(
              height: 10,
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
