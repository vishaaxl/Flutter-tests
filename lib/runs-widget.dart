import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class RunsWidget extends StatefulWidget {
  final String ball;
  final String run;

  const RunsWidget({Key? key, required this.ball, required this.run})
      : super(key: key);

  @override
  State<RunsWidget> createState() => _RunsWidgetState();
}

class _RunsWidgetState extends State<RunsWidget> with TickerProviderStateMixin {
  final runsNotifier = ValueNotifier<String>("");
  SpringSimulation? simulation;


  AnimationController? _controller;

  void _startAnim() {
    simulation = SpringSimulation(
      const SpringDescription(
        mass: 1.5,
        stiffness: 100,
        damping: 2,
      ),
      0.0, // starting point
      300.0, // ending point
      10, // velocity
    );

    _controller = AnimationController(
      vsync: this,
      upperBound: 500,
    )..addListener(() {
        setState(() {});
      });

    _controller?.animateWith(simulation as Simulation);
  }

  @override
  void initState() {
    super.initState();
    _startAnim();
    runsNotifier.addListener(() {
      _startAnim();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    runsNotifier.value  = widget.ball;

    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 175,
          top: _controller?.value,
          height: 80,
          width: 80,
          child: Container(
            color: Colors.redAccent,
            child: Center(
              child: ValueListenableBuilder<String>(
                valueListenable: runsNotifier,
                builder: (BuildContext context, String value, Widget? child) {
                  return Text(
                    "$value ${widget.run}",
                    style: const TextStyle(fontSize: 30.0, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
