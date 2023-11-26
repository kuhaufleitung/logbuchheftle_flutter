import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/LogbookStorage.dart';
import 'package:logbuchheftle_flutter/Views/LogbookPage/Inserts.dart';
import 'package:logbuchheftle_flutter/Views/LogbookPage/SingleFlightContainerView.dart';
import 'package:provider/provider.dart';

import '../../Data/SingleFlight.dart';

class LogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logbookStorage = Provider.of<LogbookStorage>(context);
    return ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [...list(logbookStorage)]);
  }

  List<Widget> list(LogbookStorage logbookStorage) {
    //need to keep track of previous flights to insert captions
    SingleFlight? oldFlight;
    List<Widget> flightsInList = [];
    Inserts inserter = Inserts();
    logbookStorage.getFlightMap().forEach((currentflid, currentFlight) {
      //we want some "caption" text when a new year, new month happens.
      //also separating flights from different days with padding
      //TODO: check if date/month to next flight is different
      List<Widget> inserts = inserter.generate(oldFlight, currentFlight);
      if (inserts.isNotEmpty) {
        flightsInList.addAll(inserter.generate(oldFlight, currentFlight));
      }
      flightsInList.add(SingleFlightContainerView(
          logbookStorage.getFlightMap()[currentflid], logbookStorage));
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
