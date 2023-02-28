import 'dart:io';

import 'package:logbuchheftle_flutter/Data/FullLogbook.dart';
import 'package:path_provider/path_provider.dart';

class LogbookStorage {
  final String _fileName = "logbook.json";
  final FullLogbook _logbook = FullLogbook();

  LogbookStorage() {
    readFromStorage();
  }

  String get getLogbook {
    return _logbook.logbookJson;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  void readFromStorage() async {
    final path = await _localFile;
    _logbook.logbookJson = await path.readAsString();
  }

  void writeToStorage(String logbookContent) async {
    final file = await _localFile;
    await file.writeAsString(logbookContent);
  }

  bool isEmpty() {
    return _logbook.logbookJson.isEmpty;
  }
}
