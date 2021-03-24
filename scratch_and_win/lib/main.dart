import 'package:flutter/material.dart';
//import 'home_page.dart';
import 'first_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      title: 'Scratch and Win',
    );
  }
}
