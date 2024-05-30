import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/data/cubits/cubit/auth_cubit.dart';
import 'package:chatie/features/auth/presentation/views/login_view.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/auth/presentation/views/widgets/text_fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginView();
              }));
              showtoast(
                  time: 5,
                  msg: 'You have successfully signed up. Please sign in now.',
                  context: context);
            } else if (state is SignUpFailure) {
              showAlert(context,
                  title: "Error", content: state.errMessage, buttonText: "Ok");
            }
          },
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 8),
                Text(
                  "Create an Account",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                const Text(
                  "First name",
                ),
                const SizedBox(height: 8),
                TextForm(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface),
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
                const SizedBox(height: 12),
                const Text(
                  "Last name",
                ),
                const SizedBox(height: 8),
                TextForm(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface),
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
                const SizedBox(height: 12),
                const Text(
                  "Bio",
                ),
                const SizedBox(height: 8),
                TextForm(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface),
                  controller: bioController,
                  icon: Icons.self_improvement,
                  hinttext: "Bio",
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'Please enter your bio ';
                    } else if (data.length < 5) {
                      return 'Bio name must be at least 5 characters';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  "Email",
                ),
                const SizedBox(height: 8),
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
                ),
                const SizedBox(height: 12),
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
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is SignUpLoading) {
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
                              //check below
                              await BlocProvider.of<AuthCubit>(context).signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  bio: bioController.text,
                                  firstName: firstNameController.text,
                                  lastname: lastnameController.text);
                            }
                            //   getToken (){
                            //     FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).get().then((value) {
                            //   }
                          },
                          child: const Text("Sign Up"));
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
//set method to write data to a specific document in the "users" collection
//using the email as the document ID.
// This will either create a new document with the specified email
// as the ID or update the existing document with the new data.

// If we want Firestore to generate a unique ID for the document, you can use the add method instead.