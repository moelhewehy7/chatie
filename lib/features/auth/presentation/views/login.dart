import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/presentation/views/sign_up.dart';
import 'package:chatie/core/app_logo.dart';
import 'package:chatie/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.onSurface),
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
              FillButton(
                onPressed: () {
                  showtoast(msg: "asdsadsdad", context: context);
                  if (formkey.currentState!.validate()) {}
                },
                child: Text(
                  'Sign In',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledTonalButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignUp();
                  }));
                },
                text: "Sign Up",
              )
            ],
          ),
        ),
      ),
    );
  }
}
