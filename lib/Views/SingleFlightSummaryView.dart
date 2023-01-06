import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/SingleFlight.dart';
import 'package:logbuchheftle_flutter/Views/FlightDetailsView.dart';

class SingleFlightSummaryView extends StatelessWidget {
  SingleFlight flight;


  SingleFlightSummaryView(this.flight, {super.key});

  TextStyle defaultBoldStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
  TextStyle defaultStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      height: 0,
      fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FlightDetailsView(selectedFlight: flight)))
            },
        child: Row(
          children: [
            Expanded(
              flex: 14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flight.date,
                              style: defaultBoldStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(flight.callsign, style: defaultStyle),
                                Text(flight.model, style: defaultStyle),
                                Text(
                                  flight.launchType.parseToSingleLetter(),
                                  style: defaultBoldStyle,
                                )
                              ],
                            ),
                          ]),
                      Column(
                        children: [
                          Text(
                            flight.pilotName,
                            style: defaultStyle,
                          ),
                          Text(flight.copilotName, style: defaultStyle)
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 0,
                    color: Colors.black54,
                  ),
                  Text(
                    "[${flight.departureTime.format(context)}] - [${flight.arrivalTime.format(context)}] -> ${flight.flightDuration} min",
                    style: defaultStyle,
                  ),
                  Text("${flight.departureLoc} - ${flight.arrivalLoc}",
                      style: defaultStyle, textAlign: TextAlign.left)
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: Icon(Icons.arrow_forward_ios_rounded),
            )
          ],
        ));
  }
}
