import 'dart:collection';

import 'package:clockwork/data/data_classes.dart';
import 'package:clockwork/data/io.dart';
import 'package:flutter/material.dart';

typedef DotwEntry = DropdownMenuEntry<DayOfTheWeek>;

class EditLessonScreen extends StatefulWidget {
  const EditLessonScreen({super.key, this.lesson, this.schedule});

  final Lesson? lesson;
  final List<Day>? schedule;

  @override
  State<EditLessonScreen> createState() => _EditLessonScreenState();
}

class _EditLessonScreenState extends State<EditLessonScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final dotwController = TextEditingController();
  final teacherController = TextEditingController();
  final classroomController = TextEditingController();

  TimeOfDay? beginTime;
  TimeOfDay? endTime;

  DayOfTheWeek? selectedDotw;

  @override
  Widget build(BuildContext context) {
    debugPrint((widget.lesson == null).toString());
    debugPrint((widget.schedule == null).toString());

    nameController.text = widget.lesson?.name ?? "";
    teacherController.text = widget.lesson?.teacher ?? "";
    classroomController.text = widget.lesson?.classroom ?? "";
    beginTime = widget.lesson?.begin;
    endTime = widget.lesson?.end;
    selectedDotw = widget.lesson?.dayOfTheWeek;
    dotwController.text = weekDaysNames[selectedDotw] ?? "";

    final ButtonStyle style = IconButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    void deleteItem() {
      debugPrint("delete item");
      List<Day> newSchedule = widget.schedule!;
      int index = newSchedule
          .firstWhere(
            (Day day) => day.lessons.any(
              (Lesson lesson) => lesson.id == widget.lesson!.id,
            ),
          )
          .lessons
          .indexWhere((Lesson lesson) => lesson.id == widget.lesson!.id);
      newSchedule
          .firstWhere(
            (Day day) => day.lessons.any(
              (Lesson lesson) => lesson.id == widget.lesson!.id,
            ),
          )
          .lessons
          .removeAt(index);
      writeScheduleToFile(newSchedule);
      setState(() {});
      Navigator.pop(context);
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit lesson"),
          actions: [
            IconButton(
              onPressed: (widget.schedule == null || widget.lesson == null)
                  ? null
                  : deleteItem,
              icon: Icon(Icons.delete),
              disabledColor: Colors.red,
            ),
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Lesson newLesson = Lesson(
                    nameController.text,
                    beginTime!,
                    endTime!,
                    id:
                        widget.lesson?.id ??
                        calcId(widget.schedule, selectedDotw!),
                    teacher: teacherController.text,
                    classroom: classroomController.text,
                    dayOfTheWeek: selectedDotw!,
                  );
                  Navigator.pop<Lesson>(context, newLesson);
                }
              },
              icon: Icon(Icons.done),
              tooltip: "Done",
              style: style,
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            return [
              TextFormField(
                autofocus: true,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lesson name is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Lesson name",
                ),
              ),
              Row(
                spacing: 8.0,
                children: [
                  Expanded(
                    child: TimeInputField(
                      label: "Start time",
                      updateTime: (time) {
                        beginTime = time;
                      },
                      initTime: beginTime,
                    ),
                  ),
                  Expanded(
                    child: TimeInputField(
                      label: "End time",
                      updateTime: (time) {
                        endTime = time;
                      },
                      initTime: endTime,
                    ),
                  ),
                ],
              ),
              DropdownMenuFormField(
                requestFocusOnTap: true,
                label: const Text("Day of the week"),
                controller: dotwController,
                initialSelection: selectedDotw,
                onSelected: (DayOfTheWeek? value) {
                  selectedDotw = value;
                },
                validator: (value) {
                  if (value == null || selectedDotw == null) {
                    return "Day of the week is required";
                  }
                  return null;
                },
                dropdownMenuEntries: UnmodifiableListView<DotwEntry>(
                  DayOfTheWeek.values.map<DotwEntry>(
                    (DayOfTheWeek dotw) =>
                        DotwEntry(label: weekDaysNames[dotw]!, value: dotw),
                  ),
                ),
              ),
              TextFormField(
                controller: teacherController,
                decoration: InputDecoration(labelText: "Classroom"),
              ),
              TextFormField(
                controller: classroomController,
                decoration: InputDecoration(labelText: "Teacher"),
              ),
            ][index];
          },
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: 5,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TimeInputField extends StatefulWidget {
  TimeInputField({
    super.key,
    required this.label,
    required this.updateTime,
    this.initTime,
  });

  final String label;
  Function(TimeOfDay?) updateTime;
  final TimeOfDay? initTime;

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  final inputController = TextEditingController();
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode focusNode;

  late TimeOfDay? selectedTime = widget.initTime;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inputController.text = selectedTime?.format(context) ?? "";
    return TextFormField(
      readOnly: true,
      controller: inputController,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: false,
        labelText: widget.label,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.label} is required";
        }
        return null;
      },
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input,
        );
        widget.updateTime(time);
        selectedTime = time;
        setState(() {
          inputController.text = selectedTime != null
              ? selectedTime!.format(context)
              : "";
          focusNode.unfocus();
        });
      },
    );
  }
}

int calcId(List<Day>? schedule, DayOfTheWeek dotw) {
  int calcId = -1;
  if (schedule != null && schedule.any((Day day) => day.dayOfTheWeek == dotw)) {
    calcId =
        (dotwNumbers[dotw]! * 10) +
        schedule
            .firstWhere((Day day) => day.dayOfTheWeek == dotw)
            .lessons
            .length;
  } else {
    calcId = dotwNumbers[dotw]! * 10;
  }
  debugPrint(calcId.toString());
  return calcId;
}
