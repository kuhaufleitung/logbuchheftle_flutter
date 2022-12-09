import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SingleFlight.dart';

class FlightCreation {
  HashMap listOfFlights = HashMap<int, SingleFlight>();
  String filePath = "assets/logbook.json";
  bool foundFile = false;

  FlightCreation() {
    populateFlightsList();
  }

  void populateFlightsList() async {
    Map jsonFileContent = await readJsonFile();
    createSingleFlights(jsonFileContent);
  }

  Future<Map> readJsonFile() async {
    String input = await rootBundle.loadString(filePath);
    if (input.isNotEmpty) {
      var map = jsonDecode(input);
      foundFile = true;
      return map;
    }
    throw const FileSystemException();
  }

  void createSingleFlights(jsonContent) {
    Map<String, dynamic> map = jsonContent as Map<String, dynamic>;
    map.forEach((key, value) {
      String pilotName = value['pilotname'];
      String copilotName = "";
      String model = value['planedesignation'];
      String callsign = value['callsign'];
      String departureLoc = value['departurelocation'];
      String arrivalLoc = value['arrivallocation'];
      int flid = int.parse(value["flid"]);
      int flightDuration = int.parse(value["flighttime"]);
      Launchtype launchType = Launchtype.NOT_INIT;
      launchType = launchType.parseToEnum(value["starttype"]);
      TimeOfDay departureTime = TimeOfDay(hour:int.parse(value["departuretime"].split(":")[0]),minute: int.parse(value["departuretime"].split(":")[1]));
      TimeOfDay arrivalTime = TimeOfDay(hour:int.parse(value["arrivaltime"].split(":")[0]),minute: int.parse(value["arrivaltime"].split(":")[1]));
      DateTime? date = DateTime.tryParse(value["dateofflight"]);

      //Copilot could be pax or FI
      if (value["finame"] == null) {
        if (value["attendantname"].toString().isNotEmpty) {
          copilotName = value["attendantname"];
        }
      } else {
        copilotName = value["finame"];
      }
      SingleFlight singleFlight = SingleFlight(
          pilotName,
          flid,
          date!,
          model,
          callsign,
          copilotName,
          launchType,
          departureLoc,
          departureTime,
          arrivalLoc,
          arrivalTime,
          flightDuration);
      listOfFlights[flid] = singleFlight;
    });
  }
}
