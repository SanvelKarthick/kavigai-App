import 'dart:io'; // Add this import

import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Karthikeyan S'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/pp.png'),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 117, 67, 198),
            ),
            accountEmail: null,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Books'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    Navigator.pushNamed(context, '/books');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.event),
                  title: const Text('Events'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    Navigator.pushNamed(context, '/events');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.meeting_room),
                  title: const Text('Meeting'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    Navigator.pushNamed(context, '/meeting');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.web),
                  title: const Text('Websites'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    Navigator.pushNamed(context, '/websites');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text('Jobs'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    Navigator.pushNamed(context, '/jobs');
                  },
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Divider(),
                // Add a divider
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Exit'),
                  onTap: () {
                    // Close the app
                    Navigator.of(context).pop(); // Close the drawer
                    exit(0); // Close the app
                  },
                ),
                // Add a spacer
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              '© Kavigai 2024 ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
