import 'package:flutter/material.dart';

class Tasks {
  final String title;
  final String category;
  final String time;
  final Color color;
  final bool isCompleted;

  Tasks({this.category, this.color, this.isCompleted, this.time, this.title});
}
