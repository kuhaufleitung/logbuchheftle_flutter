import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'SingleFlight.dart';

class LogbookStorage extends ChangeNotifier {
  final String _fileName = "logbook.json";
  String _logbookJson = "";
  LinkedHashMap _listOfFlights = LinkedHashMap<int, SingleFlight>();

  String get getLogbook {
    return _logbookJson;
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
    _logbookJson = await storageFile.readAsString();
  }

  Future<void> writeToStorage(String logbookContent) async {
    final file = await _localFile;
    await file.writeAsString(logbookContent);
  }

  bool isEmpty() {
    return _logbookJson.isEmpty;
  }

  LinkedHashMap<dynamic, dynamic> getFlightMap() {
    return _listOfFlights;
  }

  void updateFlightList(LinkedHashMap<int, SingleFlight> map) {
    _listOfFlights = map;
    notifyListeners();
  }
}
