import 'package:flutter/material.dart';
import 'package:fun_app/todo_list/tasks.dart';

class TaskRow extends StatefulWidget {
  final Tasks task;
  final double dotRadius = 12.0;

  TaskRow({this.task, Key key}) : super(key: key);

  @override
  _TaskRowState createState() => _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          new Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 32.0 - widget.dotRadius / 2),
            child: Container(
              height: widget.dotRadius,
              width: widget.dotRadius,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: widget.task.color),
            ),
          ),
          new Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.task.title,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                new Text(
                  widget.task.description,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(widget.task.time,
                style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          )
        ],
      ),
    );
  }
}
