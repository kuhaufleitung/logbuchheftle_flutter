import 'package:flutter/material.dart';

class SingleFlight {
  String pilotName;
  int flid;
  DateTime date;
  String model;
  String callsign;
  String copilotName;
  Launchtype launchType;
  String departureLoc;
  TimeOfDay departureTime;
  String arrivalLoc;
  TimeOfDay arrivalTime;
  int flightDuration;

  SingleFlight(
    this.pilotName,
    this.flid,
    this.date,
    this.model,
    this.callsign,
    this.copilotName,
    this.launchType,
    this.departureLoc,
    this.departureTime,
    this.arrivalLoc,
    this.arrivalTime,
    this.flightDuration,
  );
}

enum Launchtype {
  NOT_INIT(0),
  TMG(1),
  AEROTOW(3),
  WINCH(5);

  const Launchtype(this.id);

  final num id;
}

extension ParseFromString on Launchtype {
  Launchtype parseToEnum(String fromJson) {
    Launchtype result = Launchtype.NOT_INIT;
    switch (int.parse(fromJson)) {
      case 1:
        result = Launchtype.TMG;
        break;
      case 3:
        result = Launchtype.AEROTOW;
        break;
      case 5:
        result = Launchtype.WINCH;
        break;
    }
    return result;
  }
}
