import 'dart:io';

class FileCredentials {
  final String _fileName = 'cred.json';
  File? _handleToFile;
  String? contentFromFile;
  String _jwtBearerToken = "";

  String _serverAddress = "";
  String _port = "";
  String _username = "";
  String _password = "";

  String get getFileName {
    return _fileName;
  }

  void setHandleToFile(File newHandle) {
    _handleToFile = newHandle;
  }

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

  File? get getHandleToFile {
    return _handleToFile;
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
