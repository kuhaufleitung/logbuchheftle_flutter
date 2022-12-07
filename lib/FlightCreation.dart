import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'SingleFlight.dart';

class FlightCreation {
  HashMap listOfFlights = HashMap<int, SingleFlight>();
  String filePath = "assets/logbook.json";
  bool foundFile = false;

  FlightCreation() {
    buildFlights();
  }

  void buildFlights() {
    Future<List<Map>?> jsonFileContent = readJsonFile();
    jsonFileContent.whenComplete(() => jsonFileContent.then(
          (value) => createSingleFlights(value), /*TODO: on error here*/
        ));
  }

  Future<List<Map>> readJsonFile() async {
    String input = await rootBundle.loadString(filePath);
    if (input.isNotEmpty) {
      var map = jsonDecode(input);
      foundFile = true;
      return map;
    }
    throw const FileSystemException();
  }

  void createSingleFlights(value) {}
}
