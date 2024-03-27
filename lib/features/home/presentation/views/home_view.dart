import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentindex = 0;
  List<Widget> scrrens = [
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.pinkAccent,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: scrrens[currentindex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentindex,
        onDestinationSelected: (value) {
          currentindex = value;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.message),
              icon: Icon(Icons.message_outlined),
              label: "Message"),
          NavigationDestination(
              selectedIcon: Icon(Icons.group),
              icon: Icon(Icons.group_outlined),
              label: "Groups"),
          NavigationDestination(
              selectedIcon: Icon(Icons.contacts),
              icon: Icon(Icons.contacts_outlined),
              label: "Contacts"),
          NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: "Settings")
        ],
      ),
    );
  }
}
