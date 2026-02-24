import 'package:clockwork/data/io.dart';
import 'package:clockwork/data/data_classes.dart';
import 'package:clockwork/data/sample_lesson_data.dart';
import 'package:clockwork/screens/data_widgets.dart';
import 'package:clockwork/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currPage = 0;
  List<Day> schedule = week;
  Day debugDay = Day(DayOfTheWeek.wednesday, [
    Lesson("BAD", TimeOfDay.now(), TimeOfDay.now()),
  ]);
  // late Future<List<Day>> debugSchedule = Future.value([debugDay]);
  late List<Day> debugSchedule = [debugDay];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clockwork Alpha',
      home: Scaffold(
        appBar: AppBar(title: Text("Clockwork"), centerTitle: true),
        body: <Widget>[
          ScheduleScreen(schedule: schedule),
          DebugJson(debugDay: debugDay, schedule: schedule),
          DebugReadWrite(debugDay: debugDay, schedule: schedule),
        ][currPage],
        bottomNavigationBar: NavigationBar(
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.today),
              icon: Icon(Icons.today_outlined),
              label: 'Schedule',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu),
              selectedIcon: Icon(Icons.menu_open),
              label: 'Menu',
            ),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currPage = index;
            });
          },
          selectedIndex: currPage,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
    );
  }
}

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
          DayWidget(day: widget.debugDay),
        ],
      ),
    );
  }
}

class DebugReadWrite extends StatefulWidget {
  DebugReadWrite({super.key, required this.debugDay, required this.schedule});

  final List<Day> schedule;
  Day debugDay;

  @override
  State<DebugReadWrite> createState() => _DebugReadWriteState();
}

class _DebugReadWriteState extends State<DebugReadWrite> {
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
          DayWidget(day: widget.debugDay),
        ],
      ),
    );
  }
}
