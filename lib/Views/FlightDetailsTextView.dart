import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/SingleFlight.dart';

import '../Logic/Flights.dart';

class FlightDetailsTextView extends StatelessWidget {
  final SingleFlight selectedFlight;
  late final String consecutiveFlightNumber;

  FlightDetailsTextView({super.key, required this.selectedFlight}) {
    //hacky way to evaluate what consecutive flight number this is. As listOfFlights is saved as a HashMap, we need to cast -> list
    consecutiveFlightNumber =
        '${Flights.listOfFlights.length - Set.from(Flights.listOfFlights.keys).toList().indexOf(selectedFlight.flid)}';
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
                    Text("Flugnr.:    ", style: fatStyle()),
                    Text(consecutiveFlightNumber, style: defaultStyle())
                  ],
                ),
                Row(children: [
                  Text("Datum:    ", style: fatStyle()),
                  Text(selectedFlight.date, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Modell:    ", style: fatStyle()),
                  Text(selectedFlight.model, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Callsign:    ", style: fatStyle()),
                  Text(selectedFlight.callsign, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Pilot:    ", style: fatStyle()),
                  Text(selectedFlight.pilotName, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Begleiter:    ", style: fatStyle()),
                  Text(selectedFlight.copilotName, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Startart:    ", style: fatStyle()),
                  Text(selectedFlight.launchType.name, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Abflugort:    ", style: fatStyle()),
                  Text(selectedFlight.departureLoc, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Zielort:    ", style: fatStyle()),
                  Text(selectedFlight.arrivalLoc, style: defaultStyle())
                ]),
                Row(children: [
                  Text("Startzeit (UTC):    ", style: fatStyle()),
                  Text(selectedFlight.departureTime.format(context),
                      style: defaultStyle())
                ]),
                Row(children: [
                  Text("Landezeit(UTC):    ", style: fatStyle()),
                  Text(selectedFlight.arrivalTime.format(context),
                      style: defaultStyle())
                ]),
                Row(children: [
                  Text("Flugdauer:    ", style: fatStyle()),
                  Text('${selectedFlight.flightDuration.toString()}min',
                      style: defaultStyle())
                ]),
                Row(children: [
                  Text("Zuletzt bearbeitet am:    ", style: fatStyle()),
                  //TODO: read -> Flug zuletzt bearbeitet am...
                  Text("TODO", style: defaultStyle())
                ])
              ],
            )
          ],
        ));
  }

  TextStyle defaultStyle() {
    return const TextStyle(color: Colors.white, fontSize: 20.0);
  }

  TextStyle fatStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);
  }
}
