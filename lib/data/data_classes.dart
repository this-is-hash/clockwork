import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'data_classes.g.dart';

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
  DayOfTheWeek.sunday: "Sunday",
};

Map<String, DayOfTheWeek> weekDaysValues = {
  "Monday": DayOfTheWeek.monday,
  "Tuesday": DayOfTheWeek.tuesday,
  "Wednesday": DayOfTheWeek.wednesday,
  "Thursday": DayOfTheWeek.thursday,
  "Friday": DayOfTheWeek.friday,
  "Saturday": DayOfTheWeek.saturday,
  "Sunday": DayOfTheWeek.sunday,
};

Map<DayOfTheWeek, int> dotwNumbers = {
  DayOfTheWeek.monday: 0,
  DayOfTheWeek.tuesday: 1,
  DayOfTheWeek.wednesday: 2,
  DayOfTheWeek.thursday: 3,
  DayOfTheWeek.friday: 4,
  DayOfTheWeek.saturday: 5,
  DayOfTheWeek.sunday: 6,
};

@JsonSerializable()
class Lesson {
  Lesson(
    this.name,
    this.begin,
    this.end, {
    required this.dayOfTheWeek,
    // this.color,
    this.classroom,
    this.teacher,
    required this.id,
  });

  String name;
  int id;

  @JsonKey(name: "begin", fromJson: _todFromJson, toJson: _todToJson)
  TimeOfDay begin;
  @JsonKey(name: "end", fromJson: _todFromJson, toJson: _todToJson)
  TimeOfDay end;

  @JsonKey(name: "dotw", fromJson: dotwFromString, toJson: dotwToString)
  DayOfTheWeek dayOfTheWeek;

  // Color? color;
  String? teacher;
  String? classroom;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);

  // static DateTime _dateTimeFromEpochUs(int us) =>
  //     DateTime.fromMicrosecondsSinceEpoch(us);

  // static int? _dateTimeToEpochUs(DateTime? dateTime) =>
  //     dateTime?.microsecondsSinceEpoch;

  static TimeOfDay _todFromJson(List<dynamic> values) =>
      TimeOfDay(hour: values.first, minute: values.last);

  static List<int> _todToJson(TimeOfDay tod) => [tod.hour, tod.minute];
}

@JsonSerializable()
class Day {
  Day(this.dayOfTheWeek, this.lessons);

  @JsonKey(name: "dotw", fromJson: dotwFromString, toJson: dotwToString)
  DayOfTheWeek dayOfTheWeek;
  List<Lesson> lessons;

  /// A necessary factory constructor for creating a new Day instance
  /// from a map. Pass the map to the generated `_$DayFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DayToJson`.
  Map<String, dynamic> toJson() => _$DayToJson(this);
}

DayOfTheWeek dotwFromString(String s) => weekDaysValues[s]!;

String? dotwToString(DayOfTheWeek dotw) => weekDaysNames[dotw];
