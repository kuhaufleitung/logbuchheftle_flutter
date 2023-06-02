import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/CredentialsTextControllerData.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/CredentialsInputView.dart';
import 'package:logbuchheftle_flutter/Data/CredentialsType.dart';
import 'package:logbuchheftle_flutter/Logic/LogbookUpdate.dart';
import 'package:logbuchheftle_flutter/Views/SettingsPage/LoginStatusView.dart';
import 'package:logbuchheftle_flutter/Views/Design.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();

  final FileCredentials _fileCredentials;
  final LogbookUpdate _logbookUpdate;

  const SettingsView(this._logbookUpdate, this._fileCredentials, {super.key});
}

class _SettingsViewState extends State<SettingsView> {
  final CredentialsTextControllerData _textControllerData =
      CredentialsTextControllerData();

  @override
  void initState() {
    super.initState();
    _textControllerData.addressController =
        TextEditingController(text: widget._fileCredentials.getServerAddress);
    _textControllerData.portController =
        TextEditingController(text: widget._fileCredentials.getPort);
    _textControllerData.usernameController =
        TextEditingController(text: widget._fileCredentials.getUsername);
    _textControllerData.passwordController =
        TextEditingController(text: widget._fileCredentials.getPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Design.yearStyle("Settings")),
                Container(height: 30 * MediaQuery.of(context).textScaleFactor),
                Text("URL des Servers:",
                    style: Design.defaultSettingsViewFont(18, context)),
                CredentialsInputView(CredentialsType.ADDRESS,
                    _textControllerData.addressController),
                Container(height: 20.0),
                Text("Port des Servers (Optionals):",
                    style: Design.defaultSettingsViewFont(18, context)),
                CredentialsInputView(
                    CredentialsType.PORT, _textControllerData.portController),
                Container(height: 20.0),
                Text("Login:",
                    style: Design.defaultSettingsViewFont(18, context)),
                CredentialsInputView(CredentialsType.USERNAME,
                    _textControllerData.usernameController),
                Container(height: 20.0),
                Text("Passwort:",
                    style: Design.defaultSettingsViewFont(18, context)),
                CredentialsInputView(CredentialsType.PASSWORD,
                    _textControllerData.passwordController),
                LoginStatusView(widget._fileCredentials, _textControllerData)
              ],
            )),
        backgroundColor: Colors.black);
  }
}
