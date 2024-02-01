// // providers/todo_provider.dart

// import 'package:flutter/material.dart';
// import 'package:task/model/todo_model.dart';
// import 'package:task/repository/todo_repository.dart';

// class TodoProvider extends ChangeNotifier {
//   final TodoRepository _repository = TodoRepository();
//   List<TodoModel> _todos = [];

//   List<TodoModel> get todos => _todos;

//   Future<void> fetchTodos() async {
//     try {
//       _todos = await _repository.fetchTodos();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching todos: $e');
//     }
//   }
// }
