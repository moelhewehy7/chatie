import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
      appBar: AppBar(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        //updates the currentindex variable to reflect the selectedIndex property
        children: [
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
              label: "Chat"),
          NavigationDestination(
              selectedIcon: Icon(Icons.groups),
              icon: Icon(Icons.groups_outlined),
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
