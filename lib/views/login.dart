import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
LoginController loginController = Get.put(LoginController());

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    usernameController.text = loginController.readUsername();
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
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("logo.png", width: 200, height: 200)],
            ),
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
                hint: Text("Your email or phone number"),
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
                hint: Text("Your password"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
              ),
              obscureText: true,
            ),
            SizedBox(height: 25),
            MaterialButton(
              onPressed: () {
                loginController.saveUsername(usernameController.text);
                Get.offAndToNamed('/home');
                if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                  Get.snackbar(
                    "Error", 
                    "Please enter both username and password",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: secondaryColor,
                    colorText: Colors.white,
                  );
                  return;
                } else {
                  Get.snackbar(
                    "Login", 
                    "The username is ${usernameController.text} and the password is ${passwordController.text}",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              color: primaryColor,
              height: 50,
              minWidth: double.infinity,
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("No account?"),
                SizedBox(width: 5),
                GestureDetector(child: Text("Register", style: TextStyle(color: primaryColor)), onTap: () {
                  Get.toNamed("/register");
                }),
                Spacer(),
                Text("Forgot Password?"),
                SizedBox(width: 5),
                Text("Recover", style: TextStyle(color: primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}