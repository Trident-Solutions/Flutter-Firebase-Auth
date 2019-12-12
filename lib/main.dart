import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/login/Login.dart';

void main() => runApp(TridentApp());

class TridentApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Login(),
    );
  }
}
