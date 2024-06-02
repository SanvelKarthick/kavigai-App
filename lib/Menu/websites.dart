import 'package:flutter/material.dart';

class WebsitesPage extends StatelessWidget {
  const WebsitesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Websites Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Websites',
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
                itemCount: _websites.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    color: const Color.fromARGB(255, 206, 180, 255),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromARGB(
                            255, 234, 225, 249), // Set background color
                        child: Icon(
                          Icons.public, // Use globe icon
                          // Set icon color
                        ),
                      ),
                      title: Text(
                        'Website ${index + 1}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black), // Set text color
                      ),
                      subtitle: Text(
                        _websites[index]['url']!,
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

// Sample websites data
List<Map<String, String>> _websites = List.generate(20, (index) {
  return {'url': 'https://example${index + 1}.com'};
});
