import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/LogbookStorage.dart';

import '../Data/SingleFlight.dart';

class FlightBuilder extends ChangeNotifier {
  static final LogbookStorage _logbookStorage = LogbookStorage();

  void populateFlightsList() {
    //this is not dependent if it's the local or online version as the online version instantly overwrites the local one
    _logbookStorage.readFromStorage();
    if (!_logbookStorage.isEmpty()) {
      List<dynamic> jsonFileContent = _parseJson();
      if (_logbookStorage.getFlightMap().isNotEmpty) {
        _logbookStorage.getFlightMap().clear();
      }
      _createSingleFlights(jsonFileContent);
      notifyListeners();
    }
  }

  List<dynamic> _parseJson() {
    return jsonDecode(_logbookStorage.getLogbook);
  }

  void _createSingleFlights(jsonContent) {
    LinkedHashMap<int, SingleFlight> resultMap = LinkedHashMap();
    jsonContent.forEach((value) {
      if (value["duplicate"] == 0 && value["deleted"] == "0") {
        String pilotName = value["pilotname"];
        String copilotName = "";

        // apparently people fucked up defining the afc model in Vereinsflieger. Therefore we gotta check it...
        String model = "unknown";
        if (value["planedesignation"] != null) {
          model = value["planedesignation"];
        }

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
        resultMap[flid] = singleFlight;
      }
    });
    //this updates the menu screen
    _logbookStorage.updateFlightList(resultMap);
  }
}
