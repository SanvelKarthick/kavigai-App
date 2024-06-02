import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, Karthikeyan!'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Goals'),
            _buildList(
              [
                'Learn Flutter',
                'Learn React',
                'Learn Backend',
                'Learn Firebase'
              ],
              Icons.bolt,
            ),
            _buildSectionTitle('Books'),
            _buildList(
              [
                'Flutter Fundamentals',
                'React & React Native',
                'Software Engineering',
                'DBMS'
              ],
              Icons.book,
            ),
            _buildSectionTitle('Meetings'),
            _buildList(
              [
                'Flutter Meeting',
                'Firebase Meeting',
                'Python & R Meeting',
                'AI & ML Meeting'
              ],
              Icons.people,
            ),
            _buildSectionTitle('Events'),
            _buildList(
              [
                'ML Engineering',
                'AI Tools & Technologies',
                'Become a Developer',
                'Flutter & Firebase'
              ],
              Icons.event,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildList(List<String> items, IconData icon) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: const Color.fromARGB(255, 206, 180, 255),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 32.0),
                      const SizedBox(height: 10.0),
                      Text(
                        items[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('View'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
