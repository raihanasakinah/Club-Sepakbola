import 'package:flutter/material.dart';
import 'package:sepak_bola/screen_page/sepakbola_service.dart';

import '../model/model_bola.dart';


void main() {
  runApp(SoccerApp());
}

class SoccerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: EventListScreen(),
    );
  }
}

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = ApiService().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laga Sepak Bola Eropa 2024 - 2025'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Event>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return ListTile(
                  leading: event.strPoster != null
                      ? Image.network(
                    event.strPoster!,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  )
                      : Icon(Icons.image_not_supported),
                  title: Text(event.strEvent ?? 'No event name'),
                  subtitle: Text('${event.dateEvent ?? 'No date'} - ${event.strTime ?? 'No time'}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.strEvent ?? 'Event Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            event.strPoster != null
                ? Image.network(
              event.strPoster!,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 150);
              },
            )
                : Icon(Icons.image_not_supported, size: 150),
            SizedBox(height: 16.0),
            Text(
              event.strEvent ?? 'No event name',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('League: ${event.strLeague ?? 'No league'}'),
            Text('Season: ${event.strSeason ?? 'No season'}'),
            Text('Date: ${event.dateEvent ?? 'No date'}'),
            Text('Time: ${event.strTime ?? 'No time'}'),
          ],
        ),
      ),
    );
  }
}