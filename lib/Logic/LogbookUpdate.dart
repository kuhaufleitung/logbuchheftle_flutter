import 'package:logbuchheftle_flutter/Logic/ServerCommunication.dart';
import 'package:http/http.dart' as http;

import '../Data/FileCredentials.dart';

class LogbookUpdate {
  final FileCredentials _fileCreds;
  late ServerCommunication _serverComms;
  late http.Response _lastResponse;

  LogbookUpdate(this._fileCreds) {
    _serverComms = ServerCommunication(_fileCreds);

    //_credsAcq.readData();
    //dummy init
    //List<int> dummy = List.generate(0, (int index) => index + 0, growable: true);
    //_lastResponse = http.Response.bytes(dummy, -1);
  }

  void login() async {
    http.Response responseCode = await _serverComms.sendLoginRequest();
    setLastResponse(responseCode);
    if (_lastResponse.statusCode == 200) {
      _fileCreds.setJwtBearerToken(_lastResponse.body);
      //TODO: log
    } else {
      //TODO: log
    }
  }

  void updateLogbook() {
    Future<http.Response> responseCode = _serverComms.getLogbookUpdate();
    responseCode.then((value) => {setLastResponse(value)});
    if (_lastResponse.statusCode == 200) {
      //TODO: log + undo static Flights.dart + setup Class for logbook file
    } else {
      //TODO: log
    }
  }

  void setLastResponse(http.Response code) {
    _lastResponse = code;
  }
}
