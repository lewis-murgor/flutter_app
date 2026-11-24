import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('My App')),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("logo.png", width: 200, height: 200)],
            ),
            Text(
              "Enter Email",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Your email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Enter Username",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Your username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Enter Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Your password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
              ),
              obscureText: true,
            ),
            SizedBox(height: 25),
            Text(
              "Confirm Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: "Confirm your password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
              ),
              obscureText: true,
            ),
            SizedBox(height: 25),
            MaterialButton(
              onPressed: () {
                if (emailController.text.isEmpty || usernameController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                  Get.snackbar(
                    "Error", 
                    "Please fill in all fields",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: secondaryColor,
                    colorText: Colors.white,
                  );
                  return;
                } else if (passwordController.text != confirmPasswordController.text) {
                  Get.snackbar(
                    "Error",
                    "Passwords do not match",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: secondaryColor,
                    colorText: Colors.white,
                  );
                  return;
                } else {
                  Get.snackbar(
                    "Success",
                    "Registration successful!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: primaryColor,
                    colorText: Colors.white,
                  );
                }
              },
              color: primaryColor,
              height: 50,
              minWidth: double.infinity,
              child: Text("Sign Up"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                SizedBox(width: 5),
                GestureDetector(child: Text("Login", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)), onTap: () {
                  Get.toNamed("/");
                }),
              ],
            ),
          ],
        ),
      )
    );
  }
}