import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleFlight {
  String pilotName;
  int flid;
  String date;
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

  String getYear() {
    DateTime dateCasted = DateTime.parse(date);
    return DateFormat("y").format(dateCasted);
  }

  String getMonth() {
    DateTime dateCasted = DateTime.parse(date);
    return DateFormat("MMMM").format(dateCasted);
  }

  String getDay() {
    DateTime dateCasted = DateTime.parse(date);
    return DateFormat("d").format(dateCasted);
  }
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

  String parseToSingleLetter() {
    String result = "";
    switch (this) {
      case Launchtype.NOT_INIT:
        result = "--";
        break;
      case Launchtype.AEROTOW:
        result = "F";
        break;
      case Launchtype.TMG:
        result = "E";
        break;
      case Launchtype.WINCH:
        result = "W";
        break;
    }
    return result;
  }
}
