import 'dart:io';

class FileCredentials {
  final String _fileName = 'cred.json';
  File? _handleToFile;
  String? contentFromFile;

  String _serverIp = "";
  String _port = "";
  String _username = "";
  String _password = "";

  String get getFileName {
    return _fileName;
  }

  set setHandleToFile(File newHandle) {
    _handleToFile = newHandle;
  }

  File? get getHandleToFile {
    return _handleToFile;
  }

  void setServerIp(String serverIp) {
    _serverIp = serverIp;
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

  String get getServerIp {
    return _serverIp;
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
}
