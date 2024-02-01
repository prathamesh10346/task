// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:task/screens/todo_screen.dart';
import 'dart:convert';

import 'package:task/utils/routes.dart';
import 'package:task/utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://dummyjson.com/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];
        final int id = responseData['id'];

        GetStorage().write('token', token);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoScreen(userId: id),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid credentials'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, authRoute);
          },
          child: const Row(children: [
            SizedBox(width: 2),
            Icon(Icons.arrow_back_ios),
            Text('Back',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10.fh),
            const Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.fh),
            const Text(
              "We are excited to see you again!",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.fh),
            const Row(
              children: [
                Text(
                  "ACCOUNT INFORMATION",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 5.fh),
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E5E8),
                borderRadius: BorderRadius.circular(2),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email or phone number',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E5E8),
                borderRadius: BorderRadius.circular(2),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: _isPasswordHidden,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 10, top: 10, right: 10),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.fh),
            const Row(
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5A64EA),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            InkWell(
              onTap: () {
                _login();
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF5A64EA),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
