import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/LogbookStorage.dart';
import 'package:provider/provider.dart';
import 'Views/MenuNavigator.dart';

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
        home: ChangeNotifierProvider(
            create: (context) => LogbookStorage(),
            child: const MyHomePage(title: 'Logbook')));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MenuNavigator(widget.title);
  }
}
