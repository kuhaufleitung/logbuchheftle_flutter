import 'package:flutter/material.dart';

class FailedView extends StatelessWidget {
  final int _statusCode;

  const FailedView(this._statusCode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Wrong username/password!"),
      Text("Status-Code: $_statusCode"),
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      )
    ]);
  }
}
