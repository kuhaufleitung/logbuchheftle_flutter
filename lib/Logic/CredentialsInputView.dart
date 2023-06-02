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
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 1.0)),
          hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18 * MediaQuery.of(context).textScaleFactor),
          hintText: widget._credType.textHint),
      style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
          color: Colors.white),
    );
  }
}
