import 'package:flutter/material.dart';
import '../../Data/SingleFlight.dart';
import '../Design.dart';

class Inserts {
  List<Widget> generate(SingleFlight? oldFlight, SingleFlight? currentFlight) {
    List<Widget> whatToInclude = <Widget>[];
    if (currentFlight == null) {
      return whatToInclude;
    } else if (oldFlight == null) {
      whatToInclude.add(_firstFlight(currentFlight));
      return whatToInclude;
    } else {
      bool isFlightSameYear = oldFlight.getYear() == currentFlight.getYear();
      bool isFlightSameMonth = oldFlight.getMonth() == currentFlight.getMonth();
      bool isFlightSameDay = oldFlight.getDay() == currentFlight.getDay();

      if (isFlightSameYear) {
        if (!isFlightSameMonth) {
          whatToInclude.add(_monthWidget(currentFlight));
        }
        if (!isFlightSameDay) {
          whatToInclude.add(_daySpacer());
        }
      } else {
        whatToInclude.add(_yearWidget(currentFlight));
      }
      return whatToInclude;
    }
  }

  Widget _firstFlight(SingleFlight currentFlight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _yearWidget(currentFlight),
        _monthWidget(currentFlight),
        const Divider(height: 5, thickness: 0)
      ],
    );
  }

  Widget _yearWidget(SingleFlight currentFlight) {
    String year = currentFlight.getYear();
    return Design.yearStyle(year);
  }

  Widget _monthWidget(SingleFlight currentFlight) {
    String month = currentFlight.getMonth();
    return Design.monthStyle(month);
  }

  Widget _daySpacer() {
    return const Divider(height: 10, thickness: 0);
  }
}
