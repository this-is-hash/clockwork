import 'package:clockwork/data/lesson.dart';
import 'package:clockwork/screens/edit_screen.dart';
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditLessonScreen(lesson: lesson),
            ),
          );
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
    // TODO: Add styles to leading and trailing text
    // TODO: Add teacher display
    // TODO: Add color display?
    const timeStyle = TextStyle(fontSize: 16);

    return ListTile(
      title: Text(lesson.name),
      subtitle: lesson.classroom != null ? Text(lesson.classroom!) : null,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // -3 instead of 0 would be ideal but that's illegal
        spacing: lesson.classroom != null ? 2.0 : 0,
        children: [
          Text(lesson.begin.format(context), style: timeStyle),
          Text(lesson.end.format(context), style: timeStyle),
        ],
      ),
      trailing: Text(
        (lessonNum + 1).toString(),
        style: TextStyle(fontSize: 28),
      ),
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
          // TODO: Add styles to this text
          Text(
            weekDaysNames[day.dayOfTheWeek]!,
            style: TextStyle(fontSize: 20),
          ),
          for (Lesson lesson in day.lessons)
            LessonWidget(
              lesson: lesson,
              lessonNum: day.lessons.indexOf(lesson),
            ),
        ],
      ),
    );
  }
}
