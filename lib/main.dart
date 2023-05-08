import 'package:designcode/constants.dart';
import 'package:designcode/model/sidebar.dart';
import 'package:designcode/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';
import 'components/sidebar_row.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //scaffold is layout
        body: Container(),
      ),
    );
  }
}
