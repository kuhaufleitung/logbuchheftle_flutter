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

class Launchtype {
  static const NOT_INIT = Launchtype._(0);
  static const TMG = Launchtype._(1);
  static const AEROTOW = Launchtype._(3);
  static const WINCH = Launchtype._(5);

  static get ids => [NOT_INIT, TMG, AEROTOW, WINCH];
  final int id;

  const Launchtype._(this.id);
}
