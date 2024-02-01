import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task/model/todo_model.dart';
import 'package:task/screens/add_todo.dart';

class TodoScreen extends StatefulWidget {
  final int userId;

  TodoScreen({required this.userId});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  void _fetchTodos() async {
    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/todos/user/${widget.userId}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> todosData = responseData['todos'];

        setState(() {
          todos = todosData
              .map((todo) => Todo(
                    id: todo['id'],
                    todo: todo['todo'],
                    completed: todo['completed'],
                    userId: todo['userId'],
                  ))
              .toList();
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load TODO list'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _addTaskToList(Map<String, dynamic> taskData) {
    setState(() {
      todos.add(Todo(
        id: taskData['id'],
        todo: taskData['todo'],
        completed: taskData['completed'],
        userId: taskData['userId'],
      ));
    });
  }

  void _navigateToAddTaskPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(
          userId: widget.userId,
          onTaskAdded: _addTaskToList,
        ),
      ),
    );
  }

  void _updateTaskCompletion(int index, bool completed) {
    setState(() {
      todos[index].completed = completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/cat.png'),
            )
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TODO`s',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Hide completed',
                          style: TextStyle(
                            color: Color(0xFF3478F6),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                                width: 2.0,
                                color: todos[index].completed
                                    ? Colors.black
                                    : const Color(0xFFE8E8E8)),
                          ),
                          checkColor: Colors.white,
                          hoverColor: Colors.black,
                          activeColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          value: todos[index].completed,
                          onChanged: (value) {
                            _updateTaskCompletion(index, value ?? false);
                          },
                        ),
                        title: Text(
                          todos[index].todo,
                          style: todos[index].completed
                              ? TextStyle(
                                  color: Color(0xFF737373).withOpacity(0.2),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2,
                                  decorationColor:
                                      Color(0xFF737373).withOpacity(0.2),
                                  decorationStyle: TextDecorationStyle.wavy)
                              : const TextStyle(
                                  color: Color(0xFF737373),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                        ),
                        subtitle: Text('Completed: ${todos[index].completed}'),
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200.0),
        ),
        onPressed: _navigateToAddTaskPage,
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
