import 'package:flutter/material.dart';
import '../Data/CredentialsType.dart';

class CredentialsInputView extends StatefulWidget {
  final TextEditingController _controller;
  final CredentialsType _credType;

  const CredentialsInputView(this._credType, this._controller, {super.key});

  @override
  State<StatefulWidget> createState() => _CredentialsInputViewState();
}

class _CredentialsInputViewState extends State<CredentialsInputView> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget._controller,
        onChanged: (String value) {
          widget._controller.value = TextEditingValue(
              text: value,
              selection: TextSelection.fromPosition(
                  TextPosition(offset: widget._controller.text.length)));
        },
        keyboardType: widget._credType.kbType,
        autocorrect: false,
        obscureText: widget._credType.hiddenChars,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget._credType.textHint));
  }
}
