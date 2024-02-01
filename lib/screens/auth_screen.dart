import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task/utils/routes.dart';
import 'package:task/utils/size_config.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50.fh),
            SvgPicture.asset(
              "assets/images/Dumilogo.svg",
              width: 180,
            ),
            SizedBox(height: 40.fh),
            SvgPicture.asset(
              "assets/images/Illustrations.svg",
            ),
            SizedBox(height: 40.fh),
            const Text(
              "Welcome to Discord",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.fh),
            const Text(
              "JOin over 100 million people and you will be able to join them on Discord and receive messages",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.fh),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, signupRoute);
              },
              child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A64EA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, loginRoute);
              },
              child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA4A4A7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
