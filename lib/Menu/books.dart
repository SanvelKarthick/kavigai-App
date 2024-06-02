import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Books',
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
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Add onTap functionality here
                    },
                    child: Card(
                      elevation: 4.0,
                      color: const Color.fromARGB(255, 206, 180, 255),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(
                              255, 234, 225, 249), // Set background color
                          child: Icon(
                            Icons.book, // Use book icon
                            // Set icon color
                          ),
                        ),
                        title: Text(
                          'Book ${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black), // Set text color
                        ),
                        subtitle: Text(
                          'Author: ${_books[index]['author']}',
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black38), // Set text color
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
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

// Sample books data
List<Map<String, String>> _books = List.generate(20, (index) {
  return {'author': 'Author ${index + 1}'};
});
