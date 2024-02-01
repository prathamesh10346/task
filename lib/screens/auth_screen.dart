import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task/utils/routes.dart';
import 'package:task/utils/size_config.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/Dumilogo.svg",
      width: 180,
    );
  }
}

class IllustrationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/Illustrations.svg",
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  const AuthButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AuthController extends GetxController {
  void navigateToLogin() {
    Get.toNamed(loginRoute);
  }
}

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50.fh),
            LogoWidget(),
            SizedBox(height: 40.fh),
            IllustrationWidget(),
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
              "Join over 100 million people and you will be able to join them on Discord and receive messages",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.fh),
            AuthButton(
              text: "Register",
              color: const Color(0xFF5A64EA),
              onPressed: authController.navigateToLogin,
            ),
            const SizedBox(height: 10),
            AuthButton(
              text: "Log in",
              color: const Color(0xFFA4A4A7),
              onPressed: authController.navigateToLogin,
            ),
          ],
        ),
      ),
    );
  }
}
