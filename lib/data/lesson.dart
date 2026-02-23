import 'package:flutter/material.dart';

enum DayOfTheWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

Map<DayOfTheWeek, String> weekDaysNames = {
  DayOfTheWeek.monday: "Monday",
  DayOfTheWeek.tuesday: "Tuesday",
  DayOfTheWeek.wednesday: "Wednesday",
  DayOfTheWeek.thursday: "Thursday",
  DayOfTheWeek.friday: "Friday",
  DayOfTheWeek.saturday: "Saturday",
  DayOfTheWeek.sunday: "Sunday"
};

class Lesson {
  Lesson(
    this.name,
    this.begin,
    this.end, {
    this.color,
    this.classroom,
    this.teacher,
  });

  String name;
  TimeOfDay begin;
  TimeOfDay end;

  Color? color;
  String? teacher;
  String? classroom;
}

class Day {
  Day(this.dayOfTheWeek, this.lessons);

  DayOfTheWeek dayOfTheWeek;
  List<Lesson> lessons;
}
