import 'package:clockwork/data/lesson.dart';
import 'package:flutter/material.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({
    super.key,
    required this.lesson,
    required this.lessonNum,
  });

  final Lesson lesson;
  final int lessonNum;

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior is necessary because without it, the InkWell's animation
      // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      // This comes with a small performance cost, and you should not set [clipBehavior]
      // unless you need it.
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          debugPrint("${lesson.name} card tapped.");
        },
        child: LessonListTile(lesson: lesson, lessonNum: lessonNum),
      ),
    );
  }
}

class LessonListTile extends StatelessWidget {
  const LessonListTile({
    super.key,
    required this.lesson,
    required this.lessonNum,
  });

  final Lesson lesson;
  final int lessonNum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(lesson.name),
      subtitle: lesson.classroom != null ? Text(lesson.classroom!) : null,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5.0,
        children: [
          Text(lesson.begin.format(context)),
          Text(lesson.end.format(context)),
        ],
      ),
      trailing: Text((lessonNum + 1).toString()),
    );
  }
}

class DayWidget extends StatelessWidget {
  const DayWidget({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: [
          Text(weekDaysNames[day.dayOfTheWeek]!),
          for (Lesson lesson in day.lessons)
            LessonWidget(lesson: lesson, lessonNum: day.lessons.indexOf(lesson)),
        ],
      ),
    );
  }
}
