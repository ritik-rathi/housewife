import 'package:flutter/material.dart';

class Tasks {
  String title;
  String description;
  String time;
  Color color;
  bool completed;

  Tasks({this.description, this.color, this.completed, this.time, this.title});

  Tasks.map(dynamic obj) {
    this.title = obj["title"];
    this.time = obj["time"];
    // this.color = obj["color"];
    this.description = obj["description"];
    this.completed = obj["completed"];
  }

  String get _title => title;
  String get _time => time;
  // String get _color => color.toString();
  String get _description => description;
  bool get _completed => completed;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["time"] = time;
    // map["color"] = color;
    map["description"] = description;
    map["completed"] = completed;
    return map;
  }

  Tasks.fromMap(Map<String, dynamic> map) {
    this.title = map["title"];
    this.time = map["time"];
    // this.color = map["color"];
    this.description = map["description"];
    this.completed = map["completed"];
  }
}
