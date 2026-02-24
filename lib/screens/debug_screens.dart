import 'package:clockwork/data/data_classes.dart';
import 'package:clockwork/data/io.dart';
import 'package:clockwork/screens/data_widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DebugJson extends StatefulWidget {
  DebugJson({super.key, required this.debugDay, required this.schedule});

  final List<Day> schedule;
  Day debugDay;

  @override
  State<DebugJson> createState() => _DebugJsonState();
}

class _DebugJsonState extends State<DebugJson> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              String encodedJsonDay = encodeDayAsJsonDebug(widget.schedule[0]);
              debugPrint(encodedJsonDay);
              setState(() {
                widget.debugDay = decodeDayFromJsonDebug(encodedJsonDay);
              });
            },
            child: Text("Press for 1% chance of becoming a catboy"),
          ),
          DayWidget(day: widget.debugDay, schedule: widget.schedule),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DebugReadWrite extends StatefulWidget {
  DebugReadWrite({
    super.key,
    required this.debugSchedule,
    required this.schedule,
  });

  final List<Day> schedule;
  List<Day> debugSchedule;

  @override
  State<DebugReadWrite> createState() => _DebugReadWriteState();
}

class _DebugReadWriteState extends State<DebugReadWrite> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  writeScheduleToFile(widget.schedule);
                },
                child: Text("Write to file"),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<Day>? scheduleFromFile = await readScheduleFromFile();
                  setState(() {
                    widget.debugSchedule =
                        scheduleFromFile ?? widget.debugSchedule;
                  });
                },
                child: Text("Read from file"),
              ),
            ],
          ),
          SizedBox(
            height: 500,
            width: 500,
            child: ListView.separated(
              itemBuilder: (context, index) => DayWidget(
                day: widget.debugSchedule[index],
                schedule: widget.debugSchedule,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
              itemCount: widget.debugSchedule.length,
            ),
          ),
        ],
      ),
    );
  }
}
