import 'package:clockwork/data/data_classes.dart';
import 'package:clockwork/screens/data_widgets.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key, required this.schedule});

  List<Day> schedule;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => DayWidget(day: schedule[index]),
      separatorBuilder: (context, index) => SizedBox(height: 8.0),
      itemCount: schedule.length,
    );
  }
}
