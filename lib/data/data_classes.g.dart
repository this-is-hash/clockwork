// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
  json['name'] as String,
  Lesson._todFromJson(json['begin'] as List),
  Lesson._todFromJson(json['end'] as List),
  dayOfTheWeek: dotwFromString(json['dotw'] as String),
  classroom: json['classroom'] as String?,
  teacher: json['teacher'] as String?,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'begin': Lesson._todToJson(instance.begin),
  'end': Lesson._todToJson(instance.end),
  'dotw': dotwToString(instance.dayOfTheWeek),
  'teacher': instance.teacher,
  'classroom': instance.classroom,
};

Day _$DayFromJson(Map<String, dynamic> json) => Day(
  dotwFromString(json['dotw'] as String),
  (json['lessons'] as List<dynamic>)
      .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
  'dotw': dotwToString(instance.dayOfTheWeek),
  'lessons': instance.lessons,
};
