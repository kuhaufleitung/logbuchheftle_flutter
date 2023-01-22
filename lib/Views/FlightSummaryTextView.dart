import 'package:flutter/material.dart';

import '../Data/SingleFlight.dart';

class FlightSummaryTextView extends StatelessWidget {
  final SingleFlight selectedFlight;

  const FlightSummaryTextView({super.key, required this.selectedFlight});

  final TextStyle defaultBoldStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
  final TextStyle defaultStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      height: 0,
      fontSize: 14);

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
                          style: defaultBoldStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedFlight.callsign, style: defaultStyle),
                            Text(selectedFlight.model, style: defaultStyle),
                            Text(
                              selectedFlight.launchType.parseToSingleLetter(),
                              style: defaultBoldStyle,
                            )
                          ],
                        ),
                      ]),
                  Column(
                    children: [
                      Text(
                        selectedFlight.pilotName,
                        style: defaultStyle,
                      ),
                      Text(selectedFlight.copilotName, style: defaultStyle)
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
                style: defaultStyle,
              ),
              Text("${selectedFlight.departureLoc} - ${selectedFlight.arrivalLoc}",
                  style: defaultStyle, textAlign: TextAlign.left)
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
