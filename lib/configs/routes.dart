//import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/register.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

var myRoutes=[
  GetPage(name:"/",page:()=>LoginScreen()),
  GetPage(name: "/register",page:()=>RegistrationScreen()),
 // GetPage(name: '/dashboard', page:()=>Dashboard()),
  GetPage(name: '/home', page:()=>HomeScreen())
];