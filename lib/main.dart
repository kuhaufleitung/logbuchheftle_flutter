import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Views/MainPages.dart';
import 'Views/MainMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LogApp());
}

class LogApp extends StatelessWidget {
  const LogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lochbuchheftle',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Logbook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainPages controller = MainPages(0);

  @override
  Widget build(BuildContext context) {
    return MainMenu(widget.title);
  }
}
