import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String name;
  final String description;
  final DateTime beginDate;
  final DateTime endDate;
  final String status;

  ToDo({
    required this.name,
    required this.description,
    required this.beginDate,
    required this.endDate,
    required this.status,
  });
}

class Book {
  final String title;
  final String author;
  final DateTime publishDate;

  Book({
    required this.title,
    required this.author,
    required this.publishDate,
  });
}

class Event {
  final String eventName;
  final String location;
  final DateTime eventDate;

  Event({
    required this.eventName,
    required this.location,
    required this.eventDate,
  });
}

class Meeting {
  final String meetingName;
  final String meetingRoom;
  final DateTime meetingTime;

  Meeting({
    required this.meetingName,
    required this.meetingRoom,
    required this.meetingTime,
  });
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController todoNameController = TextEditingController();
  final TextEditingController todoDescriptionController =
      TextEditingController();
  DateTime? beginDate;
  DateTime? endDate;
  String todoStatus = 'New';

  final TextEditingController bookTitleController = TextEditingController();
  final TextEditingController bookAuthorController = TextEditingController();
  DateTime? bookPublishDate;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  DateTime? eventDate;

  final TextEditingController meetingNameController = TextEditingController();
  final TextEditingController meetingRoomController = TextEditingController();
  DateTime? meetingTime;

  List<ToDo> todoList = [];
  List<Book> bookList = [];
  List<Event> eventList = [];
  List<Meeting> meetingList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, 'ToDo');
                    },
                    child: const Text('Add ToDo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, 'Book');
                    },
                    child: const Text('Add Book'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, 'Event');
                    },
                    child: const Text('Add Event'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, 'Meeting');
                    },
                    child: const Text('Add Meeting'),
                  ),
                ],
              ),
            ),
            _buildToDoSection(),
            _buildBookSection(),
            _buildEventSection(),
            _buildMeetingSection(),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String section) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create $section'),
          content: _getForm(section),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleSubmit(section);
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _getForm(String section) {
    switch (section) {
      case 'ToDo':
        return _buildToDoForm();
      case 'Book':
        return _buildBookForm();
      case 'Event':
        return _buildEventForm();
      case 'Meeting':
        return _buildMeetingForm();
      default:
        return Container();
    }
  }

  Widget _buildToDoForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: todoNameController,
              decoration: const InputDecoration(labelText: 'ToDo Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: todoDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildDateField(
              'Begin Date',
              beginDate,
              (date) {
                setState(() {
                  beginDate = date;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildDateField(
              'End Date',
              endDate,
              (date) {
                setState(() {
                  endDate = date;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<String>(
              value: todoStatus,
              onChanged: (value) {
                setState(() {
                  todoStatus = value!;
                });
              },
              items: <String>['New', 'In Progress', 'Completed']
                  .map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: bookTitleController,
            decoration: const InputDecoration(labelText: 'Book Title'),
          ),
          TextFormField(
            controller: bookAuthorController,
            decoration: const InputDecoration(labelText: 'Author'),
          ),
          const SizedBox(height: 20.0),
          _buildDateField(
            'Publish Date',
            bookPublishDate,
            (date) {
              setState(() {
                bookPublishDate = date;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: eventNameController,
            decoration: const InputDecoration(labelText: 'Event Name'),
          ),
          TextFormField(
            controller: eventLocationController,
            decoration: const InputDecoration(labelText: 'Location'),
          ),
          const SizedBox(height: 20),
          _buildDateField(
            'Event Date',
            eventDate,
            (date) {
              setState(() {
                eventDate = date;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: meetingNameController,
            decoration: const InputDecoration(labelText: 'Meeting Name'),
          ),
          TextFormField(
            controller: meetingRoomController,
            decoration: const InputDecoration(labelText: 'Meeting Room'),
          ),
          const SizedBox(height: 20),
          _buildDateField(
            'Meeting Time',
            meetingTime,
            (date) {
              setState(() {
                meetingTime = date;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
    String labelText,
    DateTime? selectedDate,
    Function(DateTime?) onChanged,
  ) {
    TextEditingController controller = TextEditingController(
      text: selectedDate != null
          ? DateFormat('dd-MM-yyyy').format(selectedDate)
          : '',
    );

    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: () {
        _selectDate(context, selectedDate, onChanged);
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context, selectedDate, onChanged);
          },
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime?) onChanged,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      onChanged(pickedDate);
    }
  }

  void _handleSubmit(String section) {
    switch (section) {
      case 'ToDo':
        todoList.add(
          ToDo(
            name: todoNameController.text,
            description: todoDescriptionController.text,
            beginDate: beginDate!,
            endDate: endDate!,
            status: todoStatus,
          ),
        );
        saveTodoToFirestore(todoList.last);
        todoNameController.clear();
        todoDescriptionController.clear();
        setState(() {
          beginDate = null;
          endDate = null;
          todoStatus = 'New';
        });
        break;

      case 'Book':
        bookList.add(
          Book(
            title: bookTitleController.text,
            author: bookAuthorController.text,
            publishDate: bookPublishDate!,
          ),
        );
        saveBookToFirestore(bookList.last);
        bookTitleController.clear();
        bookAuthorController.clear();
        setState(() {
          bookPublishDate = null;
        });
        break;

      case 'Event':
        eventList.add(
          Event(
            eventName: eventNameController.text,
            location: eventLocationController.text,
            eventDate: eventDate!,
          ),
        );
        saveEventToFirestore(eventList.last);
        eventNameController.clear();
        eventLocationController.clear();
        setState(() {
          eventDate = null;
        });
        break;

      case 'Meeting':
        meetingList.add(
          Meeting(
            meetingName: meetingNameController.text,
            meetingRoom: meetingRoomController.text,
            meetingTime: meetingTime!,
          ),
        );
        saveMeetingToFirestore(meetingList.last);
        meetingNameController.clear();
        meetingRoomController.clear();
        setState(() {
          meetingTime = null;
        });
        break;
    }
  }

  Widget _buildToDoSection() {
    return todoList.isEmpty
        ? Container()
        : ExpansionTile(
            title: const Text('ToDos'),
            children: [
              for (var todo in todoList)
                Card(
                  child: ListTile(
                    title: Text(todo.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description: ${todo.description}"),
                        Text(
                            "Begin Date: ${DateFormat('dd-MM-yyyy').format(todo.beginDate)}"),
                        Text(
                            "End Date: ${DateFormat('dd-MM-yyyy').format(todo.endDate)}"),
                        Text("Status: ${todo.status}"),
                      ],
                    ),
                  ),
                ),
            ],
          );
  }

  Widget _buildBookSection() {
    return bookList.isEmpty
        ? Container()
        : ExpansionTile(
            title: const Text('Books'),
            children: [
              for (var book in bookList)
                ListTile(
                  title: Text(book.title),
                  subtitle: Text("Author: ${book.author}"),
                ),
            ],
          );
  }

  Widget _buildEventSection() {
    return eventList.isEmpty
        ? Container()
        : ExpansionTile(
            title: const Text('Events'),
            children: [
              for (var event in eventList)
                ListTile(
                  title: Text(event.eventName),
                  subtitle: Text("Location: ${event.location}"),
                ),
            ],
          );
  }

  Widget _buildMeetingSection() {
    return meetingList.isEmpty
        ? Container()
        : ExpansionTile(
            title: const Text('Meetings'),
            children: [
              for (var meeting in meetingList)
                ListTile(
                  title: Text(meeting.meetingName),
                  subtitle: Text("Room: ${meeting.meetingRoom}"),
                ),
            ],
          );
  }

  void saveTodoToFirestore(ToDo todo) {
    _firestore.collection('todos').add({
      'name': todo.name,
      'description': todo.description,
      'beginDate': todo.beginDate,
      'endDate': todo.endDate,
      'status': todo.status,
    });
  }

  Future<List<ToDo>> getTodosFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('todos').get();
    return querySnapshot.docs.map((doc) {
      return ToDo(
        name: doc['name'],
        description: doc['description'],
        beginDate: doc['beginDate'].toDate(),
        endDate: doc['endDate'].toDate(),
        status: doc['status'],
      );
    }).toList();
  }

  void saveEventToFirestore(Event event) {
    _firestore.collection('events').add({
      'eventName': event.eventName,
      'location': event.location,
      'eventDate': event.eventDate,
    });
  }

  Future<List<Event>> getEventsFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('events').get();
    return querySnapshot.docs.map((doc) {
      return Event(
        eventName: doc['eventName'],
        location: doc['location'],
        eventDate: doc['eventDate'].toDate(),
      );
    }).toList();
  }

  void saveMeetingToFirestore(Meeting meeting) {
    _firestore.collection('meetings').add({
      'meetingName': meeting.meetingName,
      'meetingRoom': meeting.meetingRoom,
      'meetingTime': meeting.meetingTime,
    });
  }

  Future<List<Meeting>> getMeetingsFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('meetings').get();
    return querySnapshot.docs.map((doc) {
      return Meeting(
        meetingName: doc['meetingName'],
        meetingRoom: doc['meetingRoom'],
        meetingTime: doc['meetingTime'].toDate(),
      );
    }).toList();
  }

  void saveBookToFirestore(Book book) {
    _firestore.collection('books').add({
      'title': book.title,
      'author': book.author,
      'publishDate': book.publishDate,
    });
  }

  Future<List<Book>> getBooksFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('books').get();
    return querySnapshot.docs.map((doc) {
      return Book(
        title: doc['title'],
        author: doc['author'],
        publishDate: doc['publishDate'].toDate(),
      );
    }).toList();
  }
}
