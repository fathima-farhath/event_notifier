import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScreenCalendar extends StatelessWidget {
  const ScreenCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar 2023'),
        ),
        body: SfCalendar(
          view: CalendarView.schedule,
        ));
  }
}