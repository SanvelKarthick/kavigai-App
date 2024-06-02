import 'package:flutter/material.dart';
import 'package:kdemo/Pages/home.dart';
import 'package:kdemo/Pages/goal.dart';
import 'package:kdemo/Pages/services.dart';
import 'package:kdemo/Pages/schedule.dart';
import 'package:kdemo/widgets/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const GoalPage(),
    const ServicesPage(),
    const SchedulePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('KAVIGAI'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: _getBody(_selectedIndex),
      drawer:
          const MenuDrawer(), // Remove const if MenuDrawer is not a const constructor
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Schedule',
          ),
        ],
      ),
    );
  }

  Widget _getBody(int index) {
    return _pages[index];
  }
}
