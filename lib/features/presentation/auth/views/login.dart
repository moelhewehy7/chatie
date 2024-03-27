import 'package:chatie/features/presentation/auth/views/widgets/app_logo.dart';
import 'package:chatie/features/presentation/auth/views/widgets/forgot_password.dart';
import 'package:chatie/features/presentation/auth/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';

import 'widgets/button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            EmailField(
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(data)) {
                  return 'Invalid email format.';
                }
                return null;
              },
              // In validation, returning null indicates that the input is valid
              onchanged: (data) {},
            ),
            const SizedBox(
              height: 16,
            ),
            PasswordField(
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              // In validation, returning null indicates that the input is valid
              onchanged: (data) {},
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
              onPressed: () {},
              text: 'Sign In',
            ),
            const SizedBox(
              height: 20,
            ),
            FilledTonalButton(
              onPressed: () {},
              text: "Sign Up",
            )
          ],
        ),
      ),
    );
  }
}
