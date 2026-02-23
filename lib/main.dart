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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("Clockwork"), centerTitle: true),
        body: <Widget>[
          ListView(children: [for (final Day day in week) DayWidget(day: day)]),
          Center(child: Text("Notifications")),
          Center(child: Text("Menu")),
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
            NavigationDestination(icon: Icon(Icons.menu),
            selectedIcon: Icon(Icons.menu_open),
             label: 'Menu'),
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
