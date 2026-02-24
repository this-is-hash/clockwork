import 'package:clockwork/data/data_classes.dart';
import 'package:clockwork/data/io.dart';
import 'package:clockwork/data/sample_lesson_data.dart';
import 'package:clockwork/screens/data_widgets.dart';
import 'package:clockwork/screens/edit_screen.dart';
import 'package:clockwork/screens/debug_screens.dart';
import 'package:flutter/material.dart';

// List of known bugs and flaws:
// - Removing a lesson doesn't immediately update the UI.
// - Highly inefficient data storage, a single list of lessons sorted and grouped at runtime would be better.
// - Complete lack of options and languages.

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

  // List<Day> sampleSchedule = week;
  // Day debugDay = Day(DayOfTheWeek.wednesday, [
  //   Lesson("BAD", TimeOfDay.now(), TimeOfDay.now(), id: 1),
  // ]);
  // late List<Day> debugSchedule = [debugDay];

  late Future<List<Day>?> schedule;

  @override
  void initState() {
    super.initState();
    schedule = readScheduleFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clockwork Alpha',
      // wrap scaffold with builder because of https://stackoverflow.com/a/51292613
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text("Clockwork"), centerTitle: true),
            body: <Widget>[
              FutureBuilder<List<Day>?>(
                future: schedule,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("ERROR: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      itemBuilder: (context, index) =>
                          DayWidget(day: snapshot.data![index], schedule: snapshot.data!,),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.0),
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return Center(
                      child: Text(
                        "NO SCHEDULES DETECTED. PRESS + BUTTON BELOW.",
                      ),
                    );
                  }
                },
              ),
              // DebugJson(debugDay: debugDay, schedule: sampleSchedule),
              // DebugReadWrite(debugSchedule: debugSchedule, schedule: sampleSchedule),,
              Center(child: Text("Coming soon!"),),
            ][currPage],
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                List<Day>? sch = (await schedule);
                final newLesson = await Navigator.push<Lesson>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditLessonScreen(schedule: sch),
                  ),
                );
                if (sch == null) {
                  writeScheduleToFile([
                    Day(newLesson!.dayOfTheWeek, [newLesson]),
                  ]);
                } else if (newLesson != null) {
                  if (sch.any(
                    (Day day) => day.dayOfTheWeek == newLesson.dayOfTheWeek,
                  )) {
                    sch
                        .firstWhere(
                          (Day day) =>
                              day.dayOfTheWeek == newLesson.dayOfTheWeek,
                        )
                        .lessons
                        .add(newLesson);
                  } else {
                    sch.add(Day(newLesson.dayOfTheWeek, [newLesson]));
                  }
                  writeScheduleToFile(sch);
                } else {
                  debugPrint(newLesson?.toString() ?? "its apparently null");
                  return;
                }
                setState(() {
                  schedule = readScheduleFromFile();
                });
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: NavigationBar(
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.today),
                  icon: Icon(Icons.today_outlined),
                  label: 'Schedule',
                ),
                // NavigationDestination(
                //   icon: Badge(child: Icon(Icons.notifications_sharp)),
                //   label: 'Notifications',
                // ),
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
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
          );
        },
      ),
    );
  }
}
