import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api/todos';


  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    final List data = json.decode(response.body);
    return data.map((json) => Todo.fromJson(json)).toList();
  }

  static Future<void> addTodo(String title) async {
    await http.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'title': title}));
  }

  static Future<void> toggleTodo(String id) async {
    await http.put(Uri.parse('$baseUrl/$id'));
  }

  static Future<void> deleteTodo(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}