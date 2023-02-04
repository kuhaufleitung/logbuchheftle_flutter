import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/ServerCommunication.dart';
import 'package:http/http.dart' as http;
import 'package:logbuchheftle_flutter/Views/StatusViews/FailedView.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/LoadingView.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/SuccessfulView.dart';

class LoginStatusView extends StatefulWidget {
  late final ServerCommunication _comms;
  final FileCredentials _fileCredentials;

  LoginStatusView(this._fileCredentials, {super.key}) {
    _comms = ServerCommunication(_fileCredentials);
  }

  @override
  State<StatefulWidget> createState() => _LoginStatusViewState();
}

class _LoginStatusViewState extends State<LoginStatusView> {
  var showStatus = false;
  var loginChecked = false;
  late Future<http.Response> response;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FilledButton(
        onPressed: () {
          response = widget._comms.sendLoginRequest();
          setState(() {
            showStatus = true;
            response.whenComplete(() => loginChecked = true);
          });
        },
        child: _buttonText(),
      ),
      _statusLogic()
    ]);
  }

  Widget _buttonText() {
    if (showStatus) {
      return const Text("Connection tested.");
    } else {
      return const Text("Test connection");
    }
  }

  Widget _statusLogic() {
    if (showStatus) {
      int statusCode = -1;
      response.then((value) => statusCode = value.statusCode);
      if (loginChecked) {
        if (statusCode == 200) {
          return const SuccessfulView();
        } else {
          return FailedView(statusCode);
        }
      } else {
        return const LoadingView();
      }
    } else {
      return Container(height: 0);
    }
  }
}
