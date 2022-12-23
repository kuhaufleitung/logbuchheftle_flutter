import 'package:flutter/material.dart';
import 'SingleFlight.dart';

class Inserts {
  List<Widget> generate(SingleFlight? oldFlight, SingleFlight? currentFlight) {
    List<Widget> whatToInclude = <Widget>[];
    if (currentFlight == null) {
      whatToInclude.add(const Text("last"));
      return whatToInclude;
    } else if (oldFlight == null) {
        whatToInclude.add(_firstFlight());
        return whatToInclude;
    } else {
      bool isFlightSameYear =
          oldFlight.getDate().year == currentFlight.getDate().year;
      bool isFlightSameMonth =
          oldFlight.getDate().month == currentFlight.getDate().month;
      bool isFlightSameDay =
          oldFlight.getDate().day == currentFlight.getDate().day;

      if (isFlightSameYear) {
        if (isFlightSameMonth) {
          if (!isFlightSameDay) {
            whatToInclude.add(_daySpacer());
          }
        } else {
          whatToInclude.add(_monthWidget());
        }
      } else {
        whatToInclude.add(_yearWidget());
      }
      return whatToInclude;
    }
  }

  Widget _firstFlight() {
    return const Text("first");
  }

  Widget _yearWidget() {
    return const Text("year");
  }

  Widget _monthWidget() {
    return const Text("month");
  }

  //TODO: eventually show full new date
  Widget _daySpacer() {
    return const Text("data");
  }
}
