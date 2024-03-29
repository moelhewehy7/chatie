import 'package:chatie/features/chat/presentation/views/chats_view.dart';
import 'package:chatie/features/home/presentation/views/groups_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'contacts_view.dart';
import 'settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  PageController pageController = PageController();
  //is used to control the PageView and enable programmatic page navigation.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        //updates the currentindex variable to reflect the selectedIndex property
        children: const [
          ChatView(),
          GroupsView(),
          ContactsView(),
          SettingsView()
        ],
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
          pageController.jumpToPage(value);
        },
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.chat),
              icon: Icon(IconlyLight.chat),
              label: "Chats"),
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.user_3, size: 26),
              icon: Icon(IconlyLight.user_1, size: 26),
              label: "Groups"),
          NavigationDestination(
              selectedIcon: Icon(Icons.contacts),
              icon: Icon(Icons.contacts_outlined),
              label: "Contacts"),
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.setting),
              icon: Icon(IconlyLight.setting),
              label: "Settings")
        ],
      ),
    );
  }
}
