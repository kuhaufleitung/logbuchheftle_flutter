import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Views/Design.dart';

import '../../Data/SingleFlight.dart';

class FlightSummaryTextView extends StatelessWidget {
  final SingleFlight selectedFlight;

  const FlightSummaryTextView({super.key, required this.selectedFlight});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                          selectedFlight.date,
                          style: Design.defaultSummaryViewBoldStyle(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedFlight.callsign,
                                style: Design.defaultSummaryViewStyle()),
                            Text(selectedFlight.model,
                                style: Design.defaultSummaryViewStyle()),
                            Text(
                              selectedFlight.launchType.parseToSingleLetter(),
                              style: Design.defaultSummaryViewBoldStyle(),
                            )
                          ],
                        ),
                      ]),
                  Column(
                    children: [
                      Text(
                        selectedFlight.pilotName,
                        style: Design.defaultSummaryViewStyle(),
                      ),
                      Text(selectedFlight.copilotName,
                          style: Design.defaultSummaryViewStyle())
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
                "[${selectedFlight.departureTime.format(context)}] - [${selectedFlight.arrivalTime.format(context)}] -> ${selectedFlight.flightDuration} min",
                style: Design.defaultSummaryViewStyle(),
              ),
              Text(
                  "${selectedFlight.departureLoc} - ${selectedFlight.arrivalLoc}",
                  style: Design.defaultSummaryViewStyle(),
                  textAlign: TextAlign.left)
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: Icon(Icons.arrow_forward_ios_rounded),
        )
      ],
    );
  }
}
