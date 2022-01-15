import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchTimer extends StatefulWidget {
  final Stopwatch stopwatch;
  const StopwatchTimer({
    Key? key,
    required this.stopwatch,
  }) : super(key: key);

  @override
  _TimerTimeState createState() => _TimerTimeState();
}

class _TimerTimeState extends State<StopwatchTimer> {
  void callback(Timer timer) {
    setState(() {});
  }

  @override
  void initState() {
    Timer.periodic(new Duration(milliseconds: 30), callback);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = widget.stopwatch.elapsed.inMinutes % 60;
    int seconds = widget.stopwatch.elapsed.inSeconds % 60;
    return Text(
        "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}");
  }
}
