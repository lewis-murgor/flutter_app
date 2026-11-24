import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/routes.dart';
//import 'package:flutter_application_1/views/login.dart';
//import 'package:flutter_application_1/views/register.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();

void main() {
  runApp(DaystarApp());
}
class DaystarApp extends StatelessWidget {
  const DaystarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: myRoutes,
    );
  }
}

