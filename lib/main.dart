import 'package:flutter/material.dart';

import 'routers/router.dart';

void main() => runApp(MyApp());

//前缀 stless：创建一个 StatelessWidget 的子类。
//前缀 stful：创建一个 StatefulWidget 的子类，并关联 State 子类。
//前缀 stanim：创建一个 StatefulWidget 的子类，并关联 State 子类，包含一个 AnimationController 的初始化字段

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}
