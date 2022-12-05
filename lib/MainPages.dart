import 'package:flutter/material.dart';

import 'LogList.dart';

class MainPages extends StatelessWidget {
  int index = -1;

  MainPages(this.index, {super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgets = [
    LogList(),
    Text(
      'Index 1&2: Placeholder',
      style: optionStyle,
    ),
    Text(
      'Index 1&2: Placeholder',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return _widgets.elementAt(index);
  }
}
