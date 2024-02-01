
// import 'package:http/http.dart' as http;
// import 'package:task/model/todo_model.dart';
// import 'dart:convert';


// class TodoRepository {
//   final String apiUrl = 'https://dummyjson.com/todos';

//   Future<List<TodoModel>> fetchTodos() async {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final List<dynamic> todosData = responseData['todos'];

//       return todosData.map((todoJson) => TodoModel.fromJson(todoJson)).toList();
//     } else {
//       throw Exception('Failed to fetch todos');
//     }
//   }
// }
