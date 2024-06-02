import 'package:flutter/material.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Meetings',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _meetings.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    color: const Color.fromARGB(255, 206, 180, 255),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromARGB(
                            255, 234, 225, 249), // Set background color
                        child: Icon(
                          Icons.meeting_room, // Use door icon
                          // Set icon color
                        ),
                      ),
                      title: Text(
                        'Meeting ${index + 1}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black), // Set text color to white
                      ),
                      subtitle: Text(
                        _meetings[index]['location']!,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black38), // Set text color to white
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // Add onTap functionality here
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample meetings data
List<Map<String, String>> _meetings = List.generate(20, (index) {
  return {'location': 'Location ${index + 1}'};
});
