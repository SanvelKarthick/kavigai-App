import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'goaldetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Goal class definition
class Goal {
  late String id; // Firestore document ID for unique reference
  late String name;
  late String description;
  late String beginDate;
  late String endDate;
  late String status;

  Goal({
    required this.id,
    required this.name,
    required this.description,
    required this.beginDate,
    required this.endDate,
    required this.status,
  });
}

// GoalPage, containing the full interaction for managing goals
class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final CollectionReference goalCollection =
      FirebaseFirestore.instance.collection('goals');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _showCreateGoalDialog,
              child: const Text('Create Goal'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GoalList(
                goalCollection: goalCollection,
                onEdit: _editGoal,
                onDelete: _deleteGoal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateGoalDialog() {
    final goalNameController = TextEditingController();
    final goalDescriptionController = TextEditingController();
    DateTime? beginDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create Goal'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: goalNameController,
                    decoration: const InputDecoration(
                      labelText: 'Goal Name *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: goalDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Goal Description *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildDateField(
                    'Begin Date *',
                    beginDate,
                    (date) {
                      setState(() {
                        beginDate = date;
                      });
                    },
                    context,
                  ),
                  const SizedBox(height: 16.0),
                  _buildDateField(
                    'End Date *',
                    endDate,
                    (date) {
                      setState(() {
                        endDate = date;
                      });
                    },
                    context,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleCreateGoal(
                      goalNameController.text,
                      goalDescriptionController.text,
                      beginDate,
                      endDate,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDateField(
    String labelText,
    DateTime? selectedDate,
    Function(DateTime?) onChanged,
    BuildContext context,
  ) {
    final controller = TextEditingController(
      text: selectedDate != null
          ? DateFormat('dd-MM-yyyy').format(selectedDate)
          : '',
    );

    return TextFormField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context, selectedDate, (date) {
              if (date != null) {
                onChanged(date);
                controller.text = DateFormat('dd-MM-yyyy').format(date);
              }
            });
          },
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime?) onChanged) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      onChanged(pickedDate);
    }
  }

  void _handleCreateGoal(
    String name,
    String description,
    DateTime? beginDate,
    DateTime? endDate,
  ) {
    if (name.isNotEmpty &&
        description.isNotEmpty &&
        beginDate != null &&
        endDate != null) {
      final newGoal = {
        'name': name,
        'description': description,
        'beginDate': DateFormat('dd-MM-yyyy').format(beginDate),
        'endDate': DateFormat('dd-MM-yyyy').format(endDate),
        'status': 'New',
      };

      goalCollection.add(newGoal);
    }
  }

  void _editGoal(BuildContext context, Goal goal) {
    final nameController = TextEditingController(text: goal.name);
    final descriptionController = TextEditingController(text: goal.description);

    DateTime beginDate = DateFormat('dd-MM-yyyy').parse(goal.beginDate);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(goal.endDate);

    String status = goal.status;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Goal'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        ['New', 'In Progress', 'Completed'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        status = newValue!;
                      });
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    goalCollection.doc(goal.id).update({
                      'name': nameController.text,
                      'description': descriptionController.text,
                      'beginDate': DateFormat('dd-MM-yyyy').format(beginDate),
                      'endDate': DateFormat('dd-MM-yyyy').format(endDate),
                      'status': status,
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Update'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteGoal(String goalId) {
    goalCollection.doc(goalId).delete();
  }
}

// GoalList component that displays the list of goals
class GoalList extends StatelessWidget {
  final CollectionReference goalCollection;
  final Function(BuildContext, Goal) onEdit;
  final Function(String) onDelete;

  const GoalList({
    Key? key,
    required this.goalCollection,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: goalCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading goals');
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        var goalDocs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: goalDocs.length,
          itemBuilder: (context, index) {
            var goalDoc = goalDocs[index];
            Goal goal = Goal(
              id: goalDoc.id,
              name: goalDoc['name'],
              description: goalDoc['description'],
              beginDate: goalDoc['beginDate'],
              endDate: goalDoc['endDate'],
              status: goalDoc['status'],
            );

            Color cardColor = const Color.fromARGB(255, 206, 180, 255);
            if (goal.status == 'Completed') {
              cardColor = Colors.green.shade100;
            }

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                color: cardColor,
                elevation: 4.0,
                child: ListTile(
                  title: Text(goal.name),
                  subtitle: Text(
                    'From: ${goal.beginDate} To: ${goal.endDate}\n${goal.description}',
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // Navigate to the GoalDetails page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalDetails(goal: goal),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          onEdit(context, goal);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onDelete(goal.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
