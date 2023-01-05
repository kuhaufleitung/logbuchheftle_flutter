import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/SingleFlight.dart';

class FlightDetailsView extends StatelessWidget {
  SingleFlight selectedFlight;

  FlightDetailsView({super.key, required this.selectedFlight});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Row(children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.translucent,
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        )
      ]),
      const Text("some random text"),
      Text(
        selectedFlight.pilotName,
        style: const TextStyle(color: Colors.white),
      )
    ]));
  }
}
