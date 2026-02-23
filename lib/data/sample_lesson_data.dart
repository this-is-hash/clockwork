import 'package:clockwork/data/lesson.dart';
import 'package:flutter/material.dart';

var monday = Day(DayOfTheWeek.monday, [
  Lesson(
    "История",
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 40),
    classroom: "8 кабинет",
    teacher: "Елена Владимировна",
  ),
  Lesson(
    "ОБЗР",
    TimeOfDay(hour: 8, minute: 45),
    TimeOfDay(hour: 9, minute: 25),
    classroom: "16 кабинет",
  ),
  Lesson(
    "Алгебра",
    TimeOfDay(hour: 9, minute: 30),
    TimeOfDay(hour: 10, minute: 10),
    classroom: "11 кабинет",
    teacher: "Оксана Владимировна",
  ),
  Lesson(
    "Геометрия",
    TimeOfDay(hour: 10, minute: 20),
    TimeOfDay(hour: 11, minute: 0),
    teacher: "Оксана Владимировна",
  ),
  Lesson(
    "География",
    TimeOfDay(hour: 11, minute: 10),
    TimeOfDay(hour: 11, minute: 50),
    classroom: "12 кабинет",
  ),
  Lesson(
    "Обществознание",
    TimeOfDay(hour: 11, minute: 55),
    TimeOfDay(hour: 12, minute: 35),
    classroom: "8 кабинет",
    teacher: "Елена Владимировна",
  ),
]);

var tuesday = Day(DayOfTheWeek.tuesday, [
  Lesson(
    "История",
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 40),
    classroom: "8 кабинет",
    teacher: "Елена Владимировна",
  ),
  Lesson(
    "ОБЗР",
    TimeOfDay(hour: 8, minute: 45),
    TimeOfDay(hour: 9, minute: 25),
    classroom: "16 кабинет",
  ),
  Lesson(
    "Алгебра",
    TimeOfDay(hour: 9, minute: 30),
    TimeOfDay(hour: 10, minute: 10),
    classroom: "11 кабинет",
    teacher: "Оксана Владимировна",
  ),
  Lesson(
    "Геометрия",
    TimeOfDay(hour: 10, minute: 20),
    TimeOfDay(hour: 11, minute: 0),
    teacher: "Оксана Владимировна",
  ),
  Lesson(
    "География",
    TimeOfDay(hour: 11, minute: 10),
    TimeOfDay(hour: 11, minute: 50),
    classroom: "12 кабинет",
  ),
  Lesson(
    "Обществознание",
    TimeOfDay(hour: 11, minute: 55),
    TimeOfDay(hour: 12, minute: 35),
    classroom: "8 кабинет",
    teacher: "Елена Владимировна",
  ),
]);

var wednesday = Day(DayOfTheWeek.wednesday, [
  Lesson(
    "История",
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 40),
    classroom: "8 кабинет",
    teacher: "Елена Владимировна",
  ),
  Lesson(
    "ОБЗР",
    TimeOfDay(hour: 8, minute: 45),
    TimeOfDay(hour: 9, minute: 25),
    classroom: "16 кабинет",
  ),
  Lesson(
    "Алгебра",
    TimeOfDay(hour: 9, minute: 30),
    TimeOfDay(hour: 10, minute: 10),
    classroom: "11 кабинет",
    teacher: "Оксана Владимировна",
  ),
  Lesson(
    "Геометрия",
    TimeOfDay(hour: 10, minute: 20),
    TimeOfDay(hour: 11, minute: 0),
    teacher: "Оксана Владимировна",
  ),
  Lesson(
    "География",
    TimeOfDay(hour: 11, minute: 10),
    TimeOfDay(hour: 11, minute: 50),
    classroom: "12 кабинет",
  ),
  Lesson(
    "Обществознание",
    TimeOfDay(hour: 11, minute: 55),
    TimeOfDay(hour: 12, minute: 35),
    classroom: "8 кабинет",
    teacher: "Елена Владимировна",
  ),
]);

var week = [monday, tuesday, wednesday];
