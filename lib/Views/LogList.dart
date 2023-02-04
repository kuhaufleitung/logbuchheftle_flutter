import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/FileCredentials.dart';
import 'package:logbuchheftle_flutter/Logic/LogbookUpdate.dart';
import 'package:logbuchheftle_flutter/Views/SingleFlightContainerView.dart';
import 'package:logbuchheftle_flutter/Logic/Flights.dart';
import 'package:logbuchheftle_flutter/Views/Inserts.dart';
import 'package:logbuchheftle_flutter/Views/StatusViews/LoadingView.dart';

import '../Data/SingleFlight.dart';

class LogList extends StatefulWidget {
  final FileCredentials _fileCredentials;
  const LogList(this._fileCredentials, {super.key});

  @override
  LogListState createState() => LogListState();
}

class LogListState extends State<LogList> {


  late final LogbookUpdate _logbookInst;
  LogListState();
  @override
  void initState() {
    super.initState();
    _logbookInst = LogbookUpdate(widget._fileCredentials);
    //_logbookInst.login();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Flights.populateFlightsList(),
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
    Flights.listOfFlights.forEach((currentflid, currentFlight) {
      //we want some "caption" text when a new year, new month happens.
      //also separating flights from different days with padding
      //TODO: check if date/month to next flight is different
      List<Widget> inserts = inserter.generate(oldFlight, currentFlight);
      if (inserts.isNotEmpty) {
        flightsInList.addAll(inserter.generate(oldFlight, currentFlight));
      }
      flightsInList
          .add(SingleFlightContainerView(Flights.listOfFlights[currentflid]));
      oldFlight = currentFlight;
    });
    //empty container at the end, so bottom bar doesnt cover last element
    flightsInList.add(Container(height: 100,decoration: BoxDecoration(color: Colors.transparent),));
    return flightsInList;
  }
}
