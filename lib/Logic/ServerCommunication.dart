import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';

//TODO: ResponseFromServer -> get as string -> save to file (eventually backup)
//TODO: invoke update() FlightCreation
class ServerCommunication {
  late http.Response _lastResponse;
  final FileCredentials _fileCredentials;

  ServerCommunication(this._fileCredentials);

  Future<http.Response> sendLoginRequest() async {
    //TODO: use HTTPS
    Uri url = Uri.http(
        '${_fileCredentials.getServerAddress}:${_fileCredentials.getPort}',
        '/auth');
    String userColonPass =
        "${_fileCredentials.getUsername}:${_fileCredentials.getPassword}";
    Codec<String, String> strToBase64 = utf8.fuse(base64);
    String encodedAuth = "Basic ${strToBase64.encode(userColonPass)}";
    http.Response response = http.Response("", 418);
    await http.post(url, headers: {
      HttpHeaders.authorizationHeader: encodedAuth
      //TODO on error log
    }).then((value) => {response = value},
        onError: (value) =>
            throw ("Argument Error in sendLoginRequest. Perhaps no connection to server...${response.statusCode}"));
    return response;
  }

  Future<http.Response> getLogbookUpdate() async {
    Uri url = Uri.https(_fileCredentials.getServerAddress, '/rest/logbook');
    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "Bearer ${_fileCredentials.getJwtBearerToken}"
    });
    _lastResponse = response;
    return response;
  }

  void setLastResponse(http.Response response) {
    _lastResponse = response;
  }

  http.Response get getLastResponse {
    return _lastResponse;
  }
}
