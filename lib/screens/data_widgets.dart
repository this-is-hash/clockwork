import 'package:clockwork/data/data_classes.dart';
import 'package:clockwork/data/io.dart';
import 'package:clockwork/screens/edit_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LessonWidget extends StatefulWidget {
  LessonWidget({
    super.key,
    required this.lesson,
    required this.lessonNum,
    required this.schedule,
  });

  Lesson lesson;
  final int lessonNum;
  final List<Day> schedule;

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior is necessary because without it, the InkWell's animation
      // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      // This comes with a small performance cost, and you should not set [clipBehavior]
      // unless you need it.
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          debugPrint("${widget.lesson.name} card tapped.");
          final newLesson = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditLessonScreen(
                lesson: widget.lesson,
                schedule: widget.schedule,
              ),
            ),
          );
          if (newLesson != null) {
            List<Day> newSchedule = widget.schedule;
            int index = newSchedule
                .firstWhere(
                  (Day day) => day.lessons.any(
                    (Lesson lesson) => lesson.id == newLesson.id,
                  ),
                )
                .lessons
                .indexWhere((Lesson lesson) => lesson.id == newLesson.id);
            newSchedule
                    .firstWhere(
                      (Day day) => day.lessons.any(
                        (Lesson lesson) => lesson.id == newLesson.id,
                      ),
                    )
                    .lessons[index] =
                newLesson;

            writeScheduleToFile(newSchedule);
          }
          setState(() {
            widget.lesson = newLesson ?? widget.lesson;
          });
        },
        child: LessonListTile(
          lesson: widget.lesson,
          lessonNum: widget.lessonNum,
        ),
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
    // TODO: Add styles to leading text
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
  const DayWidget({super.key, required this.day, required this.schedule});

  final Day day;
  final List<Day> schedule;

  @override
  Widget build(BuildContext context) {
    if (day.lessons.isEmpty) return Container();
    day.lessons.sort((a, b) => a.begin.compareTo(b.begin));
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
              schedule: schedule,
            ),
        ],
      ),
    );
  }
}
