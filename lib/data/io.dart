import 'dart:convert';
import 'dart:io';

import 'package:clockwork/data/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// Final path in which the schedule is stored is: Documents/PATH
// ignore: constant_identifier_names
const PATH = "Clockwork/schedule.json";

// TODO: remove debug functions
String encodeDayAsJsonDebug(Day day) {
  return jsonEncode(day);
}

Day decodeDayFromJsonDebug(String json) {
  final dayMap = jsonDecode(json) as Map<String, dynamic>;
  final day = Day.fromJson(dayMap);
  return day;
}

/// Returns the path to user's Documents directory. This directory contains user-generated files.
Future<String> get _localPath async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

/// Returns a [File] in the user's Documents directory
Future<File> get _localFile async {
  final docsPath = await _localPath;
  File("$docsPath/$PATH").createSync(recursive: true);
  return File("$docsPath/$PATH");
}

Future<File> writeScheduleToFile(List<Day> schedule) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(schedule));
}

Future<List<Day>?> readScheduleFromFile() async {
  try {
    final file = await _localFile;
    final contents = await file.readAsString();
    final jsonList = jsonDecode(contents);
    final listDecoded = List<Day>.generate(
      jsonList.length,
      (int i) => Day.fromJson(jsonList[i]),
    );
    return listDecoded;
  } catch (err) {
    debugPrint(err.toString());
    return null;
  }
}
