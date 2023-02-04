import 'package:flutter/material.dart';

class SuccessfulView extends StatelessWidget {
  const SuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      Text("Logged in!"),
      Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      )
    ]);
  }
}
