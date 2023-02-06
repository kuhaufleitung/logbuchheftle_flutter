import 'package:flutter/material.dart';
import 'package:logbuchheftle_flutter/Data/SingleFlight.dart';
import 'package:logbuchheftle_flutter/Views/LogbookPage/FlightDetailsTextView.dart';
import 'package:logbuchheftle_flutter/Views/LogbookPage/FlightSummaryTextView.dart';

class SingleFlightContainerView extends StatefulWidget {
  final SingleFlight _flight;

  const SingleFlightContainerView(this._flight, {super.key});

  @override
  SingleFlightContainerViewState createState() =>
      SingleFlightContainerViewState();
}

class SingleFlightContainerViewState extends State<SingleFlightContainerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animationWidth;
  late FlightDetailsTextView _detailsTextView;
  late FlightSummaryTextView _summaryTextView;
  late Widget _currentTextWidgetInfo;
  double _targetHeight = 100;
  double _targetWidth = 200;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _detailsTextView = FlightDetailsTextView(selectedFlight: widget._flight);
    _summaryTextView = FlightSummaryTextView(selectedFlight: widget._flight);
    _currentTextWidgetInfo = _summaryTextView;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _targetHeight = MediaQuery.of(context).size.height - 800;
          _targetWidth = MediaQuery.of(context).size.width;
          _currentTextWidgetInfo = _detailsTextView;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _currentTextWidgetInfo = _summaryTextView;
          _targetHeight = 100;
          _targetWidth = MediaQuery.of(context).size.width - 6.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController.status == AnimationStatus.dismissed) {
      _animation = Tween<double>(
              begin: _targetHeight,
              end: MediaQuery.of(context).size.height - 800)
          .animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInSine,
              reverseCurve: Curves.easeInSine));
    } else if (_animationController.status == AnimationStatus.reverse) {
      _animation = Tween<double>(
              begin: MediaQuery.of(context).size.height - 800,
              end: _targetHeight)
          .animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInSine,
              reverseCurve: Curves.easeInSine));
    }
    _animationWidth = Tween<double>(
            begin: _targetWidth, end: MediaQuery.of(context).size.width)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInSine));
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => {
              if (_animationController.isCompleted)
                {_animationController.reverse()}
              else
                {_animationController.forward()},
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FlightDetailsView(selectedFlight: _flight)))*/
            },
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 6.0),
                  height: _animation.value,
                  width: _animationWidth.value,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: const RadialGradient(
                          center: FractionalOffset(0.2, 3),
                          radius: 4,
                          stops: [0.6, 1],
                          colors: [Colors.indigo, Colors.blue])),
                  child: SizeTransition(
                      sizeFactor: _animation,
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _animationController.isAnimating ? 0 : 1,
                          child: _animationController.isAnimating ? Container() : _currentTextWidgetInfo)));
            }));
  }
}
