import 'package:clockwork/data/io.dart';
import 'package:clockwork/data/lesson.dart';
import 'package:clockwork/data/sample_lesson_data.dart';
import 'package:clockwork/screens/day_widget.dart';
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
          ListView.separated(
            itemBuilder: (context, index) => DayWidget(day: schedule[index]),
            separatorBuilder: (context, index) => SizedBox(height: 8.0),
            itemCount: schedule.length,
          ),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    String encodedJsonDay = encodeDayAsJsonDebug(schedule[0]);
                    debugPrint(encodedJsonDay);
                    setState(() {
                      debugDay = decodeDayFromJsonDebug(encodedJsonDay);
                    });
                  },
                  child: Text("Press for 1% chance of becoming a catboy"),
                ),
                DayWidget(day: debugDay),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        writeScheduleToFile(schedule);
                      },
                      child: Text("Write to file"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        List<Day> scheduleFromFile = await readScheduleFromFile();
                        setState(() {
                          debugSchedule = scheduleFromFile;
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
                    itemBuilder: (context, index) =>
                        DayWidget(day: debugSchedule[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 8.0),
                    itemCount: debugSchedule.length,
                  ),
                ),
              ],
            ),
          ),
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
