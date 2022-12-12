import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/ContainerViewFlight.dart';
import 'package:logbuchheftle_flutter/Flights.dart';

import 'SingleFlight.dart';

class LogList extends StatefulWidget {
  const LogList({super.key});

  @override
  LogListState createState() => LogListState();
}

class LogListState extends State<LogList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Flights.populateFlightsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(children: [...list()]);
          } else {
            return loading();
          }
        });
  }

  List<Widget> list() {
    List<Widget> flightsInList = [];
    for (SingleFlight element in Flights.listOfFlights.values) {
      flightsInList.add(AnimatedContainer(
        alignment: Alignment.centerLeft,
        duration: Duration.zero,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 6.0),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: const RadialGradient(
                center: FractionalOffset(0.2, 3),
                radius: 4,
                stops: [0.6, 1],
                colors: [Colors.indigo, Colors.blue])),
        child: //TODO: create UI with multiple TextContainer
            ContainerViewFlight(element)
      ));
    }
    return flightsInList;
  }

  Widget loading() {
    return Container(
        alignment: Alignment.center, child: const CircularProgressIndicator());
  }
}
