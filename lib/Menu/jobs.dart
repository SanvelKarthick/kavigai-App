import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  late TextEditingController _searchController;
  List<Map<String, String>> _filteredJobs = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredJobs = List.from(_jobs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterJobs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredJobs = List.from(_jobs);
      } else {
        _filteredJobs = _jobs
            .where((job) =>
                job['company']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterJobs,
              decoration: InputDecoration(
                hintText: 'Search Jobs',
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
                itemCount: _filteredJobs.length,
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
                            Icons.work, // Use work icon
                            // Set icon color
                          ),
                        ),
                        title: Text(
                          _filteredJobs[index]['company']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black), // Set text color
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

// Sample jobs data
List<Map<String, String>> _jobs = List.generate(20, (index) {
  return {'company': 'Company ${index + 1}'};
});
