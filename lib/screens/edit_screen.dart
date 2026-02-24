import 'package:clockwork/data/data_classes.dart';
import 'package:flutter/material.dart';

class EditLessonScreen extends StatelessWidget {
  const EditLessonScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = IconButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit lesson"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
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
              initialValue: lesson.name,
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
                    initTime: lesson.begin,
                  ),
                ),
                Expanded(
                  child: TimeInputField(
                    label: "End time",
                    initTime: lesson.end,
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: lesson.classroom,
              decoration: InputDecoration(labelText: "Classroom"),
            ),
            TextFormField(
              initialValue: lesson.teacher,
              decoration: InputDecoration(labelText: "Teacher"),
            ),
          ][index];
        },
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemCount: 4,
      ),
    );
  }
}

class TimeInputField extends StatefulWidget {
  const TimeInputField({super.key, required this.label, this.initTime});

  final String label;
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
    return TextField(
      readOnly: true,
      controller: inputController,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: false,
        labelText: widget.label,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time)
      ),
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input,
        );
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
