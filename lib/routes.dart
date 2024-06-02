import 'package:flutter/material.dart';

import 'Pages/home.dart';
import 'Pages/intro.dart';
import 'Pages/goal.dart';
import 'Pages/schedule.dart';
import 'Pages/services.dart';
import 'Menu/books.dart';
import 'Menu/events.dart';
import 'Menu/meetings.dart';
import 'Menu/websites.dart';
import 'Menu/jobs.dart';

final Map<String, WidgetBuilder> routes = {
  '/intro': (context) => const IntroScreen(),
  '/home': (context) => const HomePage(),
  '/goals': (context) => const GoalPage(),
  '/services': (context) => const ServicesPage(),
  '/schedule': (context) => const SchedulePage(),
  '/books': (context) => const BooksPage(),
  '/events': (context) => const EventsPage(),
  '/meeting': (context) => const MeetingPage(),
  '/websites': (context) => const WebsitesPage(),
  '/jobs': (context) => const JobsPage()

  // Add other configurations...
};
