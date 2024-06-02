import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Events',
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
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    color: const Color.fromARGB(255, 206, 180, 255),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromARGB(
                            255, 234, 225, 249), // Set background color
                        child: Icon(
                          Icons.event, // Use event icon
                          // Set icon color
                        ),
                      ),
                      title: Text(
                        'Event ${index + 1}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black), // Set text color
                      ),
                      subtitle: Text(
                        _events[index]['date']!,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black38), // Set text color
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

// Sample events data
List<Map<String, String>> _events = List.generate(20, (index) {
  return {'date': 'Event Date ${index + 1}'};
});
