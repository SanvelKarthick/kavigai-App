import 'package:flutter/material.dart';

class Task {
  String name;
  DateTime startDate;
  DateTime endDate;
  bool isCompleted;

  Task({
    required this.name,
    required this.startDate,
    required this.endDate,
    this.isCompleted = false,
  });
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Task> tasks = [
    Task(
      name: 'Task 1',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 5)),
    ),
    Task(
      name: 'Task 2',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      name: 'Task 3',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      name: 'Task 4',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      name: 'Task 5',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      name: 'Task 6',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      name: 'Task 7',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Schedule Content',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          child: const Text('Task'),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          child: const Text('Duration'),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  ),
                  for (int i = 0; i < tasks.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          child: GestureDetector(
                            onTap: () {
                              _editTaskName(context, i);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tasks[i].name),
                            ),
                          ),
                        ),
                        TableCell(
                          child: GestureDetector(
                            onTap: () {
                              _editTaskDuration(context, i);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _formattedDuration(
                                    tasks[i].startDate, tasks[i].endDate),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Checkbox(
                            value: tasks[i].isCompleted,
                            onChanged: (value) {
                              setState(() {
                                tasks[i].isCompleted = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formattedDuration(DateTime startDate, DateTime endDate) {
    return '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}';
  }

  void _editTaskName(BuildContext context, int index) {
    TextEditingController controller =
        TextEditingController(text: tasks[index].name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task Name'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].name = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editTaskDuration(BuildContext context, int index) async {
    DateTime? startDate = await _selectDate(context, tasks[index].startDate);
    if (startDate != null) {
      // ignore: use_build_context_synchronously
      DateTime? endDate = await _selectDate(context, tasks[index].endDate);
      if (endDate != null) {
        setState(() {
          tasks[index].startDate = startDate;
          tasks[index].endDate = endDate;
        });
      }
    }
  }

  Future<DateTime?> _selectDate(
      BuildContext context, DateTime initialDate) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }
}
