import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
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
              onchanged: (data) {},
              hinttext: 'Email',
            ),
            const SizedBox(height: 20),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: FillButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: "Reset password"),
        ));
  }
}
