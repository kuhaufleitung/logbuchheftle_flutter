import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/CredentialsInputView.dart';
import 'package:logbuchheftle_flutter/Logic/CredentialsType.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();

  final FileCredentials _fileCredentials;

  const SettingsView(this._fileCredentials, {super.key});
}

class _SettingsViewState extends State<SettingsView> {
  late final TextEditingController _addressController;
  late final TextEditingController _portController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _addressController =
        TextEditingController(text: widget._fileCredentials.getServerAddress);
    _portController =
        TextEditingController(text: widget._fileCredentials.getPort);
    _usernameController =
        TextEditingController(text: widget._fileCredentials.getUsername);
    _passwordController =
        TextEditingController(text: widget._fileCredentials.getPassword);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            //Address field
            CredentialsInputView(
                CredentialsType.ADDRESS,
                _addressController,
                widget._fileCredentials,
                "meineurldesservers.de",
                TextInputType.number),
            CredentialsInputView(CredentialsType.PORT, _portController,
                widget._fileCredentials, "8000", TextInputType.number),
            CredentialsInputView(CredentialsType.USERNAME, _usernameController,
                widget._fileCredentials, "username123", TextInputType.text),
            CredentialsInputView(CredentialsType.PASSWORD, _passwordController,
                widget._fileCredentials, "passwort", TextInputType.text),
          ],
        ));
  }
}
