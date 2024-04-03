import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 16),
            Text(
              "Create an Account",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              "First name",
            ),
            const SizedBox(height: 8),
            TextForm(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.onSurface),
              controller: firstNameController,
              icon: Icons.person,
              hinttext: "First name",
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Please enter your first name ';
                } else if (data.length > 8) {
                  return 'First name must be at most 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Last name",
            ),
            const SizedBox(height: 8),
            TextForm(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.onSurface),
              controller: lastnameController,
              icon: Icons.person,
              hinttext: "Last name",
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Please enter your last name';
                } else if (data.length > 8) {
                  return 'Last name must be at most 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Email",
            ),
            const SizedBox(height: 8),
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
                  return 'Invalid email format.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Password",
            ),
            const SizedBox(height: 8),
            PasswordField(
              controller: passwordController,
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 24,
            ),
            FillButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                text: "Sign Up")
          ],
        ),
      ),
    );
  }
}
