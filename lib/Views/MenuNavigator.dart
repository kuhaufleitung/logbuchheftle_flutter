import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Views/SettingsView.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Logic/FileCredentialsAcquisition.dart';
import 'LogList.dart';

class MenuNavigator extends StatefulWidget {
  final String title;
  final FileCredentials _fileCredentials = FileCredentials();

  MenuNavigator(this.title, {super.key});

  @override
  State<MenuNavigator> createState() => _MenuNavigatorState();
}

class _MenuNavigatorState extends State<MenuNavigator> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  late final FileCredentialsAcquisition fileCredentialsAcquisition;

  _MenuNavigatorState();

  @override
  void initState() {
    super.initState();
    fileCredentialsAcquisition =
        FileCredentialsAcquisition(widget._fileCredentials);
    fileCredentialsAcquisition.readDataFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            bottom: false,
            child: PersistentTabView(
              bottomScreenMargin: 0,
              context,
              controller: _controller,
              screens: [
                LogList(widget._fileCredentials),
                SettingsView(widget._fileCredentials)
              ],
              items: _navBarItems(),
              confineInSafeArea: false,
              backgroundColor: Colors.black.withOpacity(0.4),
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              hideNavigationBarWhenKeyboardShows: true,
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style1,
            )));
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.airplane_ticket_outlined),
        title: "Logbook",
        activeColorPrimary: Colors.red,
        activeColorSecondary: Colors.deepOrange,
        inactiveColorPrimary: Colors.deepOrange,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.red,
        activeColorSecondary: Colors.deepOrange,
        inactiveColorPrimary: Colors.deepOrange,
      ),
    ];
  }
}
