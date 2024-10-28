import 'package:dewan/controller/WebDataController.dart';
import 'package:dewan/views/screens/Homepage.dart';
import 'package:dewan/views/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ديوان سعد التميمي',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      initialBinding: AppBindings(),
    );
  }
}

class AppBindings extends Bindings{
   @override
  void dependencies() {
    Get.put<WebDataController>(WebDataController(), permanent: true);
  }
}