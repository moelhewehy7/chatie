import 'package:chatie/core/helper.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/chats/data/cubits/fecth_chats_cubit/create_chat_cubit/create_chat_cubit.dart';
import 'package:chatie/features/chats/data/cubits/fecth_chats_cubit/fetch_chats_cubit.dart';
import 'package:chatie/features/chats/presentation/views/widgets/chat_card.dart';
import 'package:chatie/features/chats/presentation/views/widgets/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with AutomaticKeepAliveClientMixin {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List rooms = [];
  // Implement AutomaticKeepAliveClientMixin in ChatViewState to maintain state
  // across tab switches.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomsheet(
            widget: BlocProvider(
              create: (context) => CreateChatCubit(),
              child: BlocConsumer<CreateChatCubit, CreateChatState>(
                listener: (context, state) {
                  if (state is CreateChatSuccess) {
                    Navigator.pop(context);
                  } else if (state is CreateChatFailure) {
                    showAlert(context,
                        title: "Error",
                        content: state.errMessage,
                        buttonText: "Ok");
                  }
                },
                builder: (context, state) {
                  if (state is CreateChatLoading) {
                    return FillButton(
                      onPressed: () {},
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        size: 20.0,
                      ),
                    );
                  } else {
                    return FillButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await BlocProvider.of<CreateChatCubit>(context)
                              .showmodalBottomSheet(context, emailController);
                          emailController.clear();
                        }
                      },
                      child: const Text("Create Chat"),
                    );
                  }
                },
              ),
            ),
            key: formKey,
            context: context,
            emailController: emailController,
            validator: (String? data) {
              if (data == null || data.isEmpty) {
                return 'Please enter an email';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(data)) {
                return 'Invalid email address.';
              }
              return null;
            },
          );
        },
        child: const Icon(
          Icons.maps_ugc,
          size: 27,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            elevation: 1,
            title: Text("Chatie"),
          ),
          BlocConsumer<FetchChatsCubit, FetchChatsState>(
            listener: (context, state) {
              if (state is FetchChatsSuccess) {
                rooms = state.rooms
                  ..sort(
                    (a, b) =>
                        b.lasteMessageTime!.compareTo(a.lasteMessageTime!),
                  ); //to sort rooms in time order
              }
            },
            builder: (context, state) {
              if (state is FetchChatsSuccess) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: rooms.length,
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChatCard(
                        chatRoom: rooms[index],
                        text: const Text("Name"),
                      ),
                    );
                  },
                ));
              } else if (state is FetchChatsInitial) {
                return const SliverFillRemaining(
                    child: Center(child: Text("No Chats")));
              } else {
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}
