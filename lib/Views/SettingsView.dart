import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/FileCredentialsAcquisition.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();

  final FileCredentials _fileCredentials;
  late final FileCredentialsAcquisition _fileCredentialsAcquisition;

  SettingsView(this._fileCredentials, {super.key}) {
    _fileCredentialsAcquisition = FileCredentialsAcquisition(_fileCredentials);
  }
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
        child: Column(
      children: [
        TextField(
            controller: _addressController,
            onSubmitted: (String value) => {
                  _addressController.value = TextEditingValue(text: value),
                  widget._fileCredentials.setServerAddress(value),
                  widget._fileCredentialsAcquisition.writeDataToStorage("ip")
                },
            autocorrect: false,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Backend Server IP-Address")),
        TextField(
            onSubmitted: (String value) => {
                  _portController.value = TextEditingValue(text: value),
                  widget._fileCredentials.setPort(value),
                  widget._fileCredentialsAcquisition.writeDataToStorage("port")
                },
            autocorrect: false,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Port")),
        TextField(
            onSubmitted: (String value) => {
                  _usernameController.value = TextEditingValue(text: value),
                  widget._fileCredentials.setUsername(value),
                  widget._fileCredentialsAcquisition
                      .writeDataToStorage("username")
                },
            autocorrect: false,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Server Username")),
        TextField(
            onSubmitted: (String value) => {
                  _passwordController.value = TextEditingValue(text: value),
                  widget._fileCredentials.setPassword(value),
                  widget._fileCredentialsAcquisition
                      .writeDataToStorage("password")
                },
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Server Password")),
        ElevatedButton(
            onPressed: () =>
                widget._fileCredentialsAcquisition.readDataFromStorage(),
            child: const Text("Read Credentials from Storage..."))
      ],
    ));
  }
}
