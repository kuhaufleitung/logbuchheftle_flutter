import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Logic/LogbookStorage.dart';

import '../Data/SingleFlight.dart';

class FlightBuilder {
  static LinkedHashMap listOfFlights = LinkedHashMap<int, SingleFlight>();
  static final LogbookStorage _logbookStorage = LogbookStorage();

  static Future<void> populateFlightsList() async {
    if (!_logbookStorage.isEmpty()) {
      Map jsonFileContent = _parseJson();
      if (listOfFlights.isNotEmpty) {
        listOfFlights.clear();
      }
      _createSingleFlights(jsonFileContent);
    }
  }

  static Map _parseJson() {
    String input = _logbookStorage.getLogbook;
    //TODO: handle empty logbook
    var map = jsonDecode(input);
    return map;
  }

  static void _createSingleFlights(jsonContent) {
    Map<String, dynamic> map = jsonContent as Map<String, dynamic>;
    map.forEach((key, value) {
      if (value["duplicate"] == 0 && value["deleted"] == "0") {
        String pilotName = value["pilotname"];
        String copilotName = "";
        String model = value["planedesignation"];
        String callsign = value['callsign'];
        String departureLoc = value["departurelocation"];
        String arrivalLoc = value["arrivallocation"];
        String date = value["dateofflight"];
        int flid = int.parse(value["flid"]);
        int flightDuration = int.parse(value["flighttime"]);
        Launchtype launchType = Launchtype.NOT_INIT;
        launchType = launchType.parseToEnum(value["starttype"]);
        TimeOfDay departureTime = TimeOfDay(
            hour: int.parse(value["departuretime"].split(":")[0]),
            minute: int.parse(value["departuretime"].split(":")[1]));
        TimeOfDay arrivalTime = TimeOfDay(
            hour: int.parse(value["arrivaltime"].split(":")[0]),
            minute: int.parse(value["arrivaltime"].split(":")[1]));

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
            date,
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
      }
    });
  }
}
