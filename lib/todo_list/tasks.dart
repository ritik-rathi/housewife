import 'package:flutter/material.dart';

class Tasks {
  final String title;
  final String category;
  final String time;
  final Color color;
  final bool completed;

  Tasks({this.category, this.color, this.completed, this.time, this.title});
}

List<Tasks> tasks = [
  new Tasks(
      title: "Make new icons",
      category: "App",
      time: "3pm",
      color: Colors.cyan,
      completed: true),
  new Tasks(
      title: "Design explorations",
      category: "Company Website",
      time: "2pm",
      color: Colors.pink,
      completed: false),
  new Tasks(
      title: "Lunch",
      category: "House",
      time: "12pm",
      color: Colors.cyan,
      completed: true),
  new Tasks(
      title: "Team Meeting",
      category: "Hangouts",
      time: "10am",
      color: Colors.cyan,
      completed: true),
];