import 'package:flutter/material.dart';

class GroupAddMembers extends StatelessWidget {
  const GroupAddMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Members"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            checkboxShape: const CircleBorder(),
            value: true,
            onChanged: (value) {},
            title: Text("Name $index"),
          );
        },
      ),
    );
  }
}
