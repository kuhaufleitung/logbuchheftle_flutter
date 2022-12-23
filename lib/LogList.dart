import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/ContainerViewFlight.dart';
import 'package:logbuchheftle_flutter/Flights.dart';
import 'package:logbuchheftle_flutter/Inserts.dart';

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
            return ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                children: [...list()]);
          } else {
            return loading();
          }
        });
  }

  List<Widget> list() {
    //need to keep track of previous flights to insert captions
    SingleFlight? oldFlight;
    List<Widget> flightsInList = [];
    Inserts inserter = Inserts();
    Flights.listOfFlights.forEach((currentflid, currentFlight) {
      //we want some "caption" text when a new year, new month happens.
      //also separating flights from different days with padding
      //TODO: check if date/month to next flight is different
      List<Widget> inserts = inserter.generate(oldFlight, currentFlight);
      if (inserts.isNotEmpty) {
        flightsInList.addAll(inserter.generate(oldFlight, currentFlight));
      }
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
          child: ContainerViewFlight(Flights.listOfFlights[currentflid])));
      oldFlight = currentFlight;
    });
    return flightsInList;
  }

  Widget loading() {
    return Container(
        alignment: Alignment.center, child: const CircularProgressIndicator());
  }
}
