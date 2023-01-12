import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../Data/FileCredentials.dart';

class FileCredentialsAcquisition {
  final FileCredentials _fileCredentials;

  FileCredentialsAcquisition(this._fileCredentials) {
    _getAndSetHandleToFile;
  }

  Future<File> get _getAndSetHandleToFile async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    return File('$path/${_fileCredentials.getFileName}');
  }

  void readData() {
    if (_fileCredentials.getHandleToFile != null) {
      _fileCredentials.contentFromFile =
          _fileCredentials.getHandleToFile?.readAsStringSync();
      setCredentialsFromFile();
    } else {
      //TODO: logging unsuccessfully read
    }
  }

  void writeData() {
    Map<String, String?> jsonableData = {
      'serverIp': _fileCredentials.getServerAddress,
      'port': _fileCredentials.getPort,
      'username': _fileCredentials.getUsername,
      'password': _fileCredentials.getPassword
    };

    String jsonOutput = jsonEncode(jsonableData);
    _fileCredentials.getHandleToFile?.writeAsStringSync(jsonOutput);
  }

  void setCredentialsFromFile() {
    //return nothing when content is empty
    Map<String, String> jsonFromFile;
    jsonFromFile = jsonDecode(_fileCredentials.contentFromFile ?? "");
    if (jsonFromFile.isNotEmpty) {
      _fileCredentials.setServerAddress(jsonFromFile['serverIp']!);
      _fileCredentials.setPort(jsonFromFile['port']!);
      _fileCredentials.setUsername(jsonFromFile['username']!);
      _fileCredentials.setPassword(jsonFromFile['password']!);
    } else {
      //TODO: logging -> no content was being read
    }
  }
}
