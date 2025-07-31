import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final data = await ApiService.fetchTodos();
    setState(() => todos = data);
  }

  Future<void> _addTodo(String title) async {
    await ApiService.addTodo(title);
    _controller.clear();
    _loadTodos();
  }

  Future<void> _toggle(String id) async {
    await ApiService.toggleTodo(id);
    _loadTodos();
  }

  Future<void> _delete(String id) async {
    await ApiService.deleteTodo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Enter a task'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTodo(_controller.text),
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadTodos,
              child: ListView(
                children: todos
                    .map((todo) => TodoItem(
                          todo: todo,
                          onToggle: () => _toggle(todo.id),
                          onDelete: () => _delete(todo.id),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}