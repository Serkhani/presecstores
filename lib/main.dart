import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Pages/homepage.dart';

void main() {
  runApp(const MyApp());
  // doWhenWindowReady(() {
  //   appWindow.size = const Size(480.0, 720.0);
  //   appWindow.minSize = const Size(300.0, 480.0);
  //   appWindow.show();
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors .blue,
            ),
            home: const HomePage());
  }
}
