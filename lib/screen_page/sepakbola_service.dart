import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/model_bola.dart';



class ApiService {
  static const String apiUrl = 'https://www.thesportsdb.com/api/v1/json/3/searchevents.php?e=Arsenal_vs_Chelsea';

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> eventsJson = data['event'];

      return eventsJson.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}