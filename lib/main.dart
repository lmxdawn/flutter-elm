import 'package:flutter/material.dart';
import 'package:flutter_elm/config/Application.dart';
import 'package:flutter_elm/navigator/tab_navigator.dart';


Future main() async {
  // 设置环境变量
  Application.init(Env.DEV);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter elm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}
