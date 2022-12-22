import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/MainPages.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_outlined),
            label: 'Logbook',
            backgroundColor: Colors.white10,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            label: 'Placeholder',
            backgroundColor: Colors.white10,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            label: 'Placeholder',
            backgroundColor: Colors.white10,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.white10,
          ),
        ],
        currentIndex: _index,
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.white70,
        onTap: _onItemTapped,
      ),
      body: SafeArea(child: MainPages(_index)),
    );
  }
}
