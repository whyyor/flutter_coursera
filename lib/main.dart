import 'components/cards/recent_course_card.dart';
import 'package:designcode/model/course.dart';
import 'package:flutter/material.dart';

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
        body: SafeArea(
          child: Container(
            child: RecentCourseCard(
              course: recentCourses[2],
            ),
          ),
        ),
      ),
    );
  }
}

