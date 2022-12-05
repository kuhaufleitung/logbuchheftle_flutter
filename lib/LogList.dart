import 'package:flutter/material.dart';

class LogList extends StatefulWidget {
  const LogList({super.key});

  @override
  LogListState createState() => LogListState();
}

class LogListState extends State<LogList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 14.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return const Divider();
        } else {
          return AnimatedContainer(
            alignment: Alignment.centerLeft,
            duration: Duration.zero,
            padding: const EdgeInsets.all(14),
            height: 100,
            //width: Checkbox.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: const RadialGradient(
                    center: FractionalOffset(0.2, 3),
                    radius: 4,
                    stops: [0.6, 1],
                    colors: [Colors.indigo, Colors.blue])),
            child: const Text('Some flight entry',
                style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }
}
