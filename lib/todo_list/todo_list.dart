import 'package:flutter/material.dart';
import 'package:fun_app/todo_list/fab.dart';
import 'package:fun_app/todo_list/task_row.dart';
import 'package:fun_app/todo_list/tasks.dart';

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

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  double _imageHeight = 256.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          ClipPath(
              clipper: ImageClipper(),
              child: Image.asset(
                'assets/images/todo.png',
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: _imageHeight,
                colorBlendMode: BlendMode.srcOver,
                color: new Color.fromARGB(120, 20, 10, 40),
              )),
          _buildHeaderIcons(context),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildTimeLine(),
          Positioned(
            right: -40.0,
            top: 150.0,
            child: Fab()
          )
        ],
      ),
    );
  }
}

Widget _buildList() {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  return Expanded(
    child: AnimatedList(
        key: _listKey,
        initialItemCount: tasks.length,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: tasks[index],
          );
        }),
  );
}

// ! make the row to display photo and name of the person
Widget _buildProfileRow() {
  return new Padding(
    padding: EdgeInsets.only(left: 64.0, top: 100.0),
    child: new Row(
      children: <Widget>[
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.circular(25.0)),
        )
      ],
    ),
  );
}

Widget _buildBottomPart() {
  return Padding(
    padding: const EdgeInsets.only(top: 270.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_buildListHeader(), _buildList()],
    ),
  );
}

Widget _buildListHeader() {
  return Padding(
    padding: EdgeInsets.only(left: 64.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          'My Tasks',
          style: new TextStyle(fontSize: 34.0),
        ),
        new Text(
          'Date', // ? enter the date from Firebase
          style: new TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ],
    ),
  );
}

Widget _buildTimeLine() {
  return Positioned(
    left: 32.0,
    top: 200.0,
    bottom: 0.0,
    child: Container(
      width: 1.0,
      color: Colors.grey[300],
    ),
  );
}

Widget _buildHeaderIcons(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25.0),
    child: Row(
      children: <Widget>[
        GestureDetector(onTap: (){
          Navigator.pushNamed(context, '.');
        },child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 32.0)),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              "TODO",
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        new Icon(Icons.linear_scale, color: Colors.white),
      ],
    ),
  );
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 50.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
