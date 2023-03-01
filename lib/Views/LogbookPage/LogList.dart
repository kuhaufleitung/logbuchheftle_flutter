
import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Logic/FlightBuilder.dart';
import 'package:logbuchheftle_flutter/Views/LogbookPage/Inserts.dart';
import 'package:logbuchheftle_flutter/Views/LogbookPage/SingleFlightContainerView.dart';

import '../../Data/SingleFlight.dart';
import '../StatusViews/LoadingView.dart';

class LogList extends StatefulWidget {

  const LogList({super.key});

  @override
  LogListState createState() => LogListState();
}

class LogListState extends State<LogList> {
  LogListState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FlightBuilder.listOfFlights),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Colors.black,
                body: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: [...list()]));
          } else {
            return const LoadingView();
          }
        });
  }

  List<Widget> list() {
    //need to keep track of previous flights to insert captions
    SingleFlight? oldFlight;
    List<Widget> flightsInList = [];
    Inserts inserter = Inserts();
    FlightBuilder.listOfFlights.forEach((currentflid, currentFlight) {
      //we want some "caption" text when a new year, new month happens.
      //also separating flights from different days with padding
      //TODO: check if date/month to next flight is different
      List<Widget> inserts = inserter.generate(oldFlight, currentFlight);
      if (inserts.isNotEmpty) {
        flightsInList.addAll(inserter.generate(oldFlight, currentFlight));
      }
      flightsInList.add(
          SingleFlightContainerView(FlightBuilder.listOfFlights[currentflid]));
      oldFlight = currentFlight;
    });
    //empty container at the end, so bottom bar doesn't cover last element
    flightsInList.add(Container(
      height: 100,
      decoration: const BoxDecoration(color: Colors.transparent),
    ));
    return flightsInList;
  }
}
