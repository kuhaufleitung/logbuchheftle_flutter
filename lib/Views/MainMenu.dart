import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Views/MainPages.dart';

class MainMenu extends StatefulWidget {
  final String title;

  const MainMenu(this.title, {super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _index = 0;

  _MainMenuState();

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.airplane_ticket_outlined),
            label: 'Logbook',
          ),
          NavigationDestination(
            icon: Icon(Icons.tab),
            label: 'Placeholder',
          ),
          NavigationDestination(
            icon: Icon(Icons.tab),
            label: 'Placeholder',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedIndex: _index,
        onDestinationSelected: _onItemTapped,
      ),
      body: SafeArea(child: MainPages(_index)),
    );
  }
}
