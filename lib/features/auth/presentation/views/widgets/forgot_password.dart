import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/data/cubits/cubit/auth_cubit.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResetpasswordSuccess) {
              showAlert(context,
                  title: "Password Reset Email Sent",
                  content: state.errMessage,
                  buttonText: "Ok");
            } else if (state is Resetpasswordfailure) {
              showAlert(context,
                  title: "Error", content: state.errMessage, buttonText: "Ok");
            }
          },
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                Text(
                  "Forgot Your Password 🔑",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                const Text(
                  "We've got you covered. Enter your registered email to reset your password. An email will be sent to the provided address with instructions on how to reset your password.",
                ),
                const SizedBox(height: 25),
                const Text(
                  "Your Registered Email",
                ),
                const SizedBox(height: 10),
                TextForm(
                  controller: emailController,
                  icon: Icons.email,
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(data)) {
                      return 'Invalid email format.';
                    }
                    return null;
                  },
                  hinttext: 'Email',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is ResetpasswordLoading) {
                return FillButton(
                    onPressed: () {},
                    child: SpinKitFadingCircle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: 20.0,
                    ));
              } else {
                return FillButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context)
                            .resetPassword(email: emailController.text);
                      }
                    },
                    child: const Text("Reset password"));
              }
            },
          ),
        ));
  }
}
