import 'package:chatie/features/groups/data/cubits/create_group_cubit/create_group_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/groups/presentation/views/widgets/create_group.dart';
import 'package:chatie/features/groups/presentation/views/widgets/group_chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/fetch_groups_cubit/fetch_groups_cubit.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  List<GroupModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => CreateGroupCubit(),
                          child: const CreateGroup(),
                        )),
              );
            },
            child: const Icon(
              Icons.maps_ugc,
              size: 27,
            )),
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              elevation: 1,
              title: Text("Chatie"),
            ),
            BlocBuilder<FetchGroupsCubit, FetchGroupsState>(
              builder: (context, state) {
                if (state is FetchGroupsSuccess) {
                  groups = state.groups
                    ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: groups.length,
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GroupChatCard(
                          groupModel: groups[index],
                        ),
                      );
                    },
                  ));
                } else if (state is FetchGroupsEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "No groups found",
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: SizedBox(),
                  );
                }
              },
            ),
          ],
        ));
  }
}
