import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/FileCredentialsAcquisition.dart';
import 'package:logbuchheftle_flutter/Logic/ServerCommunication.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/FailedView.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/LoadingView.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/SuccessfulView.dart';

import '../../Data/CredentialsTextControllerData.dart';

class LoginStatusView extends StatefulWidget {
  late final ServerCommunication _comms;
  final FileCredentials _fileCredentials;
  final CredentialsTextControllerData _credentialsTextControllerData;

  LoginStatusView(this._fileCredentials, this._credentialsTextControllerData, {super.key}) {
    _comms = ServerCommunication(_fileCredentials);
  }

  @override
  State<StatefulWidget> createState() => _LoginStatusViewState();
}

class _LoginStatusViewState extends State<LoginStatusView> {
  final ValueNotifier<int> _showStatus = ValueNotifier<int>(0);
  final ValueNotifier<int> _greyOutButton = ValueNotifier<int>(0);
  late final FileCredentialsAcquisition _fileCredentialsAcquisition;
  
  @override
  void initState() {
    super.initState();
    _fileCredentialsAcquisition = FileCredentialsAcquisition(widget._fileCredentials);
  }

  // TODO: store/retrieve lastStatus
  Widget _lastStatus = const LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ValueListenableBuilder<int>(
          valueListenable: _greyOutButton,
          builder: (context, value, parent) {
            return ElevatedButton(
                onPressed: value == 0 ? () => _showStatus.value += 1 : null,
                child: const Text("Test connection"));
          }),
      ValueListenableBuilder<int>(
          valueListenable: _showStatus,
          builder: (context, value, parent) {
            if (value == 0) {
              return Container(
                height: 0,
              );
            } else {
              //this section gets executed when button is pressed.
              //-> set controller values in runtime and save to storage
              //ALWAYS SET before writing to disk!
              setCredentials();
              _fileCredentialsAcquisition.writeAllDataToStorage();
            }
            //no need to update widget when already logged in
            if (_lastStatus.runtimeType == const SuccessfulView().runtimeType) {
              _greyOutButton.value += 1;
              return const SuccessfulView();
            }
            return FutureBuilder(
                future: widget._comms.sendLoginRequest(),
                builder: (BuildContext context,
                    AsyncSnapshot<http.Response> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.statusCode == 200) {
                      _lastStatus = const SuccessfulView();
                      _greyOutButton.value += 1;
                      return const SuccessfulView();
                    } else {
                      return FailedView(snapshot.data!.statusCode);
                    }
                  } else {
                    return const LoadingView();
                  }
                });
          })
    ]);
  }

  void setCredentials() {
    widget._fileCredentials.setServerAddress(widget._credentialsTextControllerData.addressController.value.text);
    widget._fileCredentials.setPort(widget._credentialsTextControllerData.portController.value.text);
    widget._fileCredentials.setUsername(widget._credentialsTextControllerData.usernameController.value.text);
    widget._fileCredentials.setPassword(widget._credentialsTextControllerData.passwordController.value.text);
  }
}
