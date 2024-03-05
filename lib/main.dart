// ignore_for_file: prefer_const_constructors

import 'package:cinema_swift/controller/auth_controller.dart';
import 'package:cinema_swift/controller/common_controller.dart';
import 'package:cinema_swift/controller/location_controller.dart';
import 'package:cinema_swift/screens/splash_screen.dart';
import 'package:cinema_swift/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(LocationController());
  Get.put(CommonController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MyTheme.myLightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
