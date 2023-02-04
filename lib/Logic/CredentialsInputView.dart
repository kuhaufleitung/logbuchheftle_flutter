import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/FileCredentialsAcquisition.dart';

import '../Data/CredentialsType.dart';

class CredentialsInputView extends StatefulWidget {
  final TextEditingController _controller;
  final FileCredentials _fileCredentials;
  late final FileCredentialsAcquisition _fileCredentialsAcquisition;
  final CredentialsType _credType;

  ///@params: controllerInst, fileCredentials, textHint, KeyboardType
  ///Focus widget is needed as we can switch to different form where onChanged isn't called on the old one
  CredentialsInputView(this._credType, this._controller, this._fileCredentials,
      {super.key}) {
    _fileCredentialsAcquisition = FileCredentialsAcquisition(_fileCredentials);
  }

  @override
  State<StatefulWidget> createState() => _CredentialsInputViewState();
}

class _CredentialsInputViewState extends State<CredentialsInputView> {
  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (isFocused) {
          if (!isFocused) {
            callAppropriateCredentialSaveFunc();
            widget._fileCredentialsAcquisition
                .writeDataToStorage(widget._credType);
          }
        },
        child: TextField(
            controller: widget._controller,
            onChanged: (String value) {
              widget._controller.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.fromPosition(
                      TextPosition(offset: widget._controller.text.length)));
            },
            keyboardType: widget._credType.kbType,
            autocorrect: false,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: widget._credType.textHint)));
  }

  void callAppropriateCredentialSaveFunc() {
    switch (widget._credType) {
      case CredentialsType.ADDRESS:
        widget._fileCredentials.setServerAddress(widget._controller.value.text);
        break;
      case CredentialsType.PORT:
        widget._fileCredentials.setPort(widget._controller.value.text);
        break;
      case CredentialsType.USERNAME:
        widget._fileCredentials.setUsername(widget._controller.value.text);
        break;
      case CredentialsType.PASSWORD:
        widget._fileCredentials.setPassword(widget._controller.value.text);
        break;
    }
  }
}
