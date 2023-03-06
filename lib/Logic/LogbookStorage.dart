import 'dart:io';

import 'package:logbuchheftle_flutter/Data/FullLogbook.dart';
import 'package:path_provider/path_provider.dart';

class LogbookStorage {
  final String _fileName = "logbook.json";
  final FullLogbook _logbook = FullLogbook();

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

  Future<void> readFromStorage() async {
    final storageFile = await _localFile;
    if (!storageFile.existsSync()) {
      storageFile.createSync();
    }
    _logbook.logbookJson = await storageFile.readAsString();
  }

  Future<void> writeToStorage(String logbookContent) async {
    final file = await _localFile;
    await file.writeAsString(logbookContent);
  }

  bool isEmpty() {
    return _logbook.logbookJson.isEmpty;
  }
}
