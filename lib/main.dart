import 'package:chatie/features/auth/data/cubits/cubit/auth_cubit.dart';
import 'package:chatie/features/auth/presentation/views/login_view.dart';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/chats/data/cubits/create_chat_cubit/create_chat_cubit.dart';
import 'package:chatie/features/chats/data/cubits/fecth_chats_cubit/fetch_chats_cubit.dart';
import 'package:chatie/features/contacts/data/cubits/fetch_contacts_cubit/fetch_contacts_cubit.dart';
import 'package:chatie/features/groups/data/cubits/fetch_groups_cubit/fetch_groups_cubit.dart';
import 'package:chatie/features/home/presentation/views/home_view.dart';
import 'package:chatie/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chatie());
}

class Chatie extends StatelessWidget {
  const Chatie({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => FetchChatsCubit()
            ..fetchChats(email: FirebaseAuth.instance.currentUser!.email!),
        ),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => CreateChatCubit()),
        BlocProvider(
          create: (context) => FetchGroupsCubit()..fetchGroups(),
        ),
        BlocProvider(
          create: (context) => FetchContactsCubit()..fetchContacts(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo, brightness: Brightness.dark),
            useMaterial3: true),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const HomeView();
            } else {
              return const LoginView();
            }
          },
        ),
      ),
    );
  }
}
