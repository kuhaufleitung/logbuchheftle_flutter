import 'dart:io';

class FileCredentials {
  String _jwtBearerToken = "";

  String _serverAddress = "";
  String _port = "";
  String _username = "";
  String _password = "";


  void setServerAddress(String serverIp) {
    _serverAddress = serverIp;
  }

  void setPort(String port) {
    _port = port;
  }

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setJwtBearerToken(String newToken) {
    _jwtBearerToken = newToken;
  }

  String get getServerAddress {
    return _serverAddress;
  }

  String get getPort {
    return _port;
  }

  String get getUsername {
    return _username;
  }

  String get getPassword {
    return _password;
  }

  String get getJwtBearerToken {
    return _jwtBearerToken;
  }
}
