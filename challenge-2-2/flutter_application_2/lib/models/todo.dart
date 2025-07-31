class Todo {
  final String id;
  final String title;
  final bool completed;

  Todo({required this.id, required this.title, required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['_id'],
        title: json['title'],
        completed: json['completed'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
      };
}
