import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/FlightBuilder.dart';
import 'package:logbuchheftle_flutter/Logic/LogbookStorage.dart';
import 'package:logbuchheftle_flutter/Logic/LogbookUpdate.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/LoadingView.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Logic/FileCredentialsAcquisition.dart';
import 'LogbookPage/LogList.dart';
import 'SettingsPage/SettingsView.dart';

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
  LogbookUpdate? _logbookUpdate;
  var isLoading = true;

  _MenuNavigatorState();

  @override
  void initState() {
    super.initState();
    fileCredentialsAcquisition =
        FileCredentialsAcquisition(widget._fileCredentials);
    _awaitDataLoad();
  }

  _awaitDataLoad() async {
    _logbookUpdate = LogbookUpdate(widget._fileCredentials);
    await fileCredentialsAcquisition.readDataFromStorage();
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      LogbookStorage storage = LogbookStorage();
      await storage.readFromStorage();
    } else {
      await _logbookUpdate?.login();
      await _logbookUpdate?.updateLogbook();
      setState(() {
        isLoading = false;
      });
    }
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
                _buildLogList(),
                SettingsView(_logbookUpdate!, widget._fileCredentials)
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

  Widget _buildLogList() {
    return FutureBuilder(
      future: FlightBuilder.populateFlightsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return LogList();
        } else {
          return const LoadingView();
        }
      },
    );
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
