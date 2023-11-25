import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_v2_tutorial/model/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    final response = await http.get(
      Uri.https('dummyjson.com', '/todos'),
      headers: {'Content-Type': 'application/json'},
    );
    final data = (jsonDecode(response.body) as Map<String, dynamic>);

    final todos = List<Map<String, dynamic>>.from(data["todos"]);

    return todos
        .cast<Map<String, dynamic>>()
        .map((e) => Todo.fromJson(e))
        .toList();
  }

  Future<void> addTodo(Todo todo) async {
    await http.post(
      Uri.https('dummyjson.com', '/todos/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    final previousState = await future;

    state = AsyncData([
      ...previousState,
      todo,
    ]);
  }
}
