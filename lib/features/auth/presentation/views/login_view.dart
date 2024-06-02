import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/data/cubits/cubit/auth_cubit.dart';
import 'package:chatie/features/auth/presentation/views/sign_up_view.dart';
import 'package:chatie/core/app_logo.dart';
import 'package:chatie/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:chatie/features/chats/data/cubits/fecth_chats_cubit/fetch_chats_cubit.dart';
import 'package:chatie/features/contacts/data/cubits/fetch_contacts_cubit/fetch_contacts_cubit.dart';
import 'package:chatie/features/home/data/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:chatie/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'widgets/button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LogInSuccess) {
              BlocProvider.of<FetchChatsCubit>(context)
                  .fetchChats(email: emailController.text, context: context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomeView();
              }));
              showtoast(
                  time: 1,
                  msg: 'You have successfully signed in.',
                  context: context);
            } else if (state is LogInFailure) {
              showAlert(context,
                  title: "Error", content: state.errMessage, buttonText: "Ok");
            }
          },
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                Text(
                  "Welcome Back! 👋",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextForm(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface),
                  controller: emailController,
                  icon: Icons.email,
                  hinttext: "Email",
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(data)) {
                      return 'Invalid email address.';
                    }
                    return null;
                  },
                  // In validation, returning null indicates that the input is valid
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordField(
                  controller: passwordController,
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  // In validation, returning null indicates that the input is valid
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPassword();
                        }));
                      },
                      child: const Text(
                        "Forgot Password?",
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is LogInLoading) {
                      return FillButton(
                          onPressed: () {},
                          child: SpinKitFadingCircle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            size: 20.0,
                          ));
                    } else {
                      return FillButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<AuthCubit>(context)
                                .logIn(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              FirebaseHelper().updateStatus(online: true);
                              BlocProvider.of<UserDataCubit>(context)
                                  .getUserData();
                              BlocProvider.of<UserDataCubit>(context)
                                  .updateT(email: emailController.text);
                              BlocProvider.of<FetchChatsCubit>(context)
                                  .fetchChats(
                                      email: emailController.text,
                                      context: context);
                              BlocProvider.of<FetchContactsCubit>(context)
                                  .fetchContacts();
                            });
                          }
                        },
                        child: const Text(
                          'Sign In',
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledTonalButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUp();
                    }));
                  },
                  text: "Sign Up",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
