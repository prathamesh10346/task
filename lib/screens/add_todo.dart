import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task/utils/size_config.dart';

class AddTaskPage extends StatefulWidget {
  final int userId;
  final Function(Map<String, dynamic>) onTaskAdded;

  AddTaskPage({required this.userId, required this.onTaskAdded});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isToday = true;

  void _addTask() {
    String task = _taskController.text.trim();
    if (task.isNotEmpty) {
      widget.onTaskAdded({
        'id': -1,
        'todo': task,
        'completed': false,
        'userId': widget.userId,
        'time': _selectedTime,
        'isToday': _isToday,
      });
      Navigator.pop(context);
    } else {
      _showErrorSnackbar('Please enter a task');
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 1,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 50.0),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.fh,
            ),
            const Text(
              'Add a Task',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildTaskInput(),
            const SizedBox(height: 20.0),
            _buildTimePicker(),
            const SizedBox(height: 20.0),
            _buildTodaySwitch(),
            SizedBox(height: 40.0.fh),
            _buildDoneButton(),
            const SizedBox(height: 16.0),
            _buildNoteText(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskInput() {
    return Row(
      children: [
        const Text(
          'Name',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 20.0),
        Container(
          width: 200.0.fw,
          child: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              hintText: 'Task',
              hintStyle: TextStyle(
                color: Color(0xFFB3B1B1),
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Row(
      children: [
        Text(
          'Hours: ${_selectedTime.format(context)}',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 20.0),
        ElevatedButton(
          onPressed: () => _pickTime(),
          child: const Text('Pick Time'),
        ),
      ],
    );
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Widget _buildTodaySwitch() {
    return Row(
      children: [
        const Text(
          'Today',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Switch(
          activeColor: const Color(0xFF34C759),
          focusColor: const Color(0xFF34C759),
          hoverColor: const Color(0xFF34C759),
          thumbColor: const MaterialStatePropertyAll(Color(0xFFFFFFFF)),
          overlayColor: const MaterialStatePropertyAll(Color(0xFF34C759)),
          trackColor: MaterialStatePropertyAll(
              _isToday ? const Color(0xFF34C759) : Colors.grey),
          activeTrackColor: Colors.white,
          value: _isToday,
          onChanged: (value) {
            setState(() {
              _isToday = value;
            });
          },
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget _buildDoneButton() {
    return InkWell(
      onTap: () {
        _addTask();
      },
      child: Container(
        height: 46,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Done",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoteText() {
    return Text(
      "If you disable today, the task will be considered as tomorrow",
      style: TextStyle(
        color: const Color(0xFF737373).withOpacity(0.4),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
