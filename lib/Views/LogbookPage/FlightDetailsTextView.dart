import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/LogbookStorage.dart';
import 'package:logbuchheftle_flutter/Data/SingleFlight.dart';
import 'package:logbuchheftle_flutter/Views/Design.dart';

import '../../Logic/FlightBuilder.dart';

class FlightDetailsTextView extends StatelessWidget {
  final SingleFlight selectedFlight;
  late final String consecutiveFlightNumber;
  final LogbookStorage _logbookStorage;

  FlightDetailsTextView(this._logbookStorage,
      {super.key, required this.selectedFlight}) {
    //hacky way to evaluate what consecutive flight number this is. As listOfFlights is saved as a HashMap, we need to cast -> list
    consecutiveFlightNumber =
        '${_logbookStorage.getFlightMap().length - Set.from(_logbookStorage.getFlightMap().keys).toList().indexOf(selectedFlight.flid)}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [_listOfDetails(context)]));
  }

  Widget _listOfDetails(context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Flugnr.:    ",
                        style: Design.defaultDetailsViewBoldStyle()),
                    Text(consecutiveFlightNumber,
                        style: Design.defaultDetailsViewStyle())
                  ],
                ),
                Row(children: [
                  Text("Datum:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.date,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Modell:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.model,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Callsign:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.callsign,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Pilot:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.pilotName,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Begleiter:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.copilotName,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Startart:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.launchType.name,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Abflugort:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.departureLoc,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Zielort:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.arrivalLoc,
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Startzeit (UTC):    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.departureTime.format(context),
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Landezeit(UTC):    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text(selectedFlight.arrivalTime.format(context),
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Flugdauer:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  Text('${selectedFlight.flightDuration.toString()}min',
                      style: Design.defaultDetailsViewStyle())
                ]),
                Row(children: [
                  Text("Zuletzt bearbeitet am:    ",
                      style: Design.defaultDetailsViewBoldStyle()),
                  //TODO: read -> Flug zuletzt bearbeitet am...
                  Text("TODO", style: Design.defaultDetailsViewStyle())
                ])
              ],
            )
          ],
        ));
  }
}
