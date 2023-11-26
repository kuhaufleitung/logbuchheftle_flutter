import 'package:http/http.dart' as http;
import 'package:logbuchheftle_flutter/Logic/FlightBuilder.dart';
import 'package:logbuchheftle_flutter/Data/LogbookStorage.dart';
import 'package:logbuchheftle_flutter/Logic/ServerCommunication.dart';

import '../Data/FileCredentials.dart';

class LogbookUpdate {
  final FileCredentials _fileCreds;
  late ServerCommunication _serverComms;
  late bool isLocalDb;
  late FlightBuilder _flightBuilder;

  LogbookUpdate(this._fileCreds, FlightBuilder flightBuilder) {
    _serverComms = ServerCommunication(_fileCreds);
    _flightBuilder = flightBuilder;
  }

  Future<void> login() async {
    http.Response response = await _serverComms.sendLoginRequest();
    if (response.statusCode == 200) {
      _fileCreds.setJwtBearerToken(response.body);
      //TODO: log
    } else {
      //TODO: log
    }
  }

  void updateLogbook() async {
    http.Response response = await _serverComms.getLogbookUpdate();
    if (response.statusCode == 200) {
      isLocalDb = false;
      LogbookStorage logbookStorage = LogbookStorage();
      await logbookStorage.writeToStorage(response.body);
      await logbookStorage.readFromStorage();
      _flightBuilder.populateFlightsList();
      //TODO: log
    } else {
      isLocalDb = true;
      //TODO: log
    }
  }
}
