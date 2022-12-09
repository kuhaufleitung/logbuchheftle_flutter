import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Flights.dart';

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
          return list();
        } else {
          return loading();
        }
      });
  }

  Widget list() {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 10.0),
        itemCount: Flights.listOfFlights.length,
        itemBuilder: (BuildContext context, int i) {
          return AnimatedContainer(
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
            child: const Text('Some flight entry',
                style: TextStyle(color: Colors.white)),
          );
        });
  }

  Widget loading() {
    return Container(
        alignment: Alignment.center, child: const CircularProgressIndicator());
  }

  Widget singleFlightAsListObject() {
    //TODO: write entry to listobject
    return Container();
  }

}
