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

  //Focus widget is needed as we can switch to different form where onChanged isn't called on the old one
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            //IP field
            Focus(
                onFocusChange: (isFocused) {
                  if (!isFocused) {
                    widget._fileCredentials
                        .setServerAddress(_addressController.value.text);
                    widget._fileCredentialsAcquisition.writeDataToStorage("ip");
                  }
                },
                child: TextField(
                    controller: _addressController,
                    onChanged: (String value) {
                      _addressController.value = TextEditingValue(
                          text: value,
                          selection: TextSelection.fromPosition(TextPosition(
                              offset: _addressController.text.length)));
                    },
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Backend Server IP-Address"))),
            //Port field
            Focus(
                onFocusChange: (isFocused) {
                  if (!isFocused) {
                    widget._fileCredentials.setPort(_portController.value.text);
                    widget._fileCredentialsAcquisition
                        .writeDataToStorage("port");
                  }
                },
                child: TextField(
                    controller: _portController,
                    onChanged: (String value) {
                      _portController.value = TextEditingValue(
                          text: value,
                          selection: TextSelection.fromPosition(TextPosition(
                              offset: _portController.text.length)));
                    },
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Port"))),
            //Username field
            Focus(
                onFocusChange: (isFocused) {
                  if (!isFocused) {
                    widget._fileCredentials
                        .setUsername(_usernameController.value.text);
                    widget._fileCredentialsAcquisition
                        .writeDataToStorage("username");
                  }
                },
                child: TextField(
                    controller: _usernameController,
                    onChanged: (String value) {
                      _usernameController.value = TextEditingValue(
                          text: value,
                          selection: TextSelection.fromPosition(TextPosition(
                              offset: _usernameController.text.length)));
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Server Username"))),
            //Password field
            Focus(
                onFocusChange: (isFocused) {
                  if (!isFocused) {
                    widget._fileCredentials
                        .setPassword(_passwordController.value.text);
                    widget._fileCredentialsAcquisition
                        .writeDataToStorage("password");
                  }
                },
                child: TextField(
                    controller: _passwordController,
                    onChanged: (String value) {
                      _passwordController.value = TextEditingValue(
                          text: value,
                          selection: TextSelection.fromPosition(TextPosition(
                              offset: _passwordController.text.length)));
                    },
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Server Password"))),
            ElevatedButton(
                onPressed: () =>
                    widget._fileCredentialsAcquisition.readDataFromStorage(),
                child: const Text("Read Credentials from Storage..."))
          ],
        ));
  }
}
