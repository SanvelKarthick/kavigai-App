import 'package:flutter/material.dart';
import 'goal.dart'; // Import Goal class definition

class GoalDetails extends StatelessWidget {
  final Goal goal; // The goal to display

  const GoalDetails(
      {super.key, required this.goal}); // Constructor to accept a Goal object

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(goal.name), // Display the goal name in the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(goal.description), // Display goal description
            const SizedBox(height: 8.0), // Add space between sections
            const Text(
              'Begin Date:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(goal.beginDate), // Display goal begin date
            const SizedBox(height: 8.0),
            const Text(
              'End Date:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(goal.endDate), // Display goal end date
            const SizedBox(height: 8.0),
            const Text(
              'Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(goal.status), // Display goal status
          ],
        ),
      ),
    );
  }
}
