import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_groups_state.dart';

class FetchGroupsCubit extends Cubit<FetchGroupsState> {
  FetchGroupsCubit() : super(FetchGroupsInitial());

  Future<void> fetchGroups() async {
    emit(FetchGroupsLoading());
    try {
      FirebaseFirestore.instance
          .collection("groups")
          .snapshots()
          .listen((event) {
        if (event.docs.isNotEmpty) {
          List<GroupModel> groups = [];
          for (var doc in event.docs) {
            groups.add(GroupModel.fromjson(doc));
          }
          emit(FetchGroupsSuccess(groups: groups));
        } else {
          emit(FetchGroupsEmpty());
        }
      });
    } catch (e) {
      emit(FetchGroupsFailure(errMessage: "Oops something went wrong"));
    }
  }
}
