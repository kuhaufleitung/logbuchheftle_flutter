import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../Data/FileCredentials.dart';

class FileCredentialsAcquisition {
  FileCredentials? fileCredentials;

  FileCredentialsAcquisition() {
    fileCredentials = FileCredentials();
    _getAndSetHandleToFile;
  }

  Future<File> get _getAndSetHandleToFile async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    return File('$path/${fileCredentials?.getFileName}');
  }

  void readData() {
    if (fileCredentials?.getHandleToFile != null) {
      fileCredentials?.contentFromFile =
          fileCredentials?.getHandleToFile?.readAsStringSync();
      setCredentials();
    } else {
      //TODO: logging unsuccessfully read
    }
  }

  void writeData() {
    Map<String, String?> jsonableData = {
      'serverIp': fileCredentials?.getServerIp,
      'port': fileCredentials?.getPort,
      'username': fileCredentials?.getUsername,
      'password': fileCredentials?.getPassword
    };

    String jsonOutput = jsonEncode(jsonableData);
    fileCredentials?.getHandleToFile?.writeAsStringSync(jsonOutput);
  }

  void setCredentials() {
    //return nothing when content is empty
    Map<String, String> jsonFromFile;
    jsonFromFile = jsonDecode(fileCredentials?.contentFromFile ?? "");
    if (jsonFromFile.isNotEmpty) {
      fileCredentials?.setServerIp(jsonFromFile['serverIp']!);
      fileCredentials?.setPort(jsonFromFile['port']!);
      fileCredentials?.setUsername(jsonFromFile['username']!);
      fileCredentials?.setPassword(jsonFromFile['password']!);
    } else {
      //TODO: logging -> no content was being read
    }
  }
}
