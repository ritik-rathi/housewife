import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_app/firebase_service.dart';
import 'package:fun_app/todo_list/tasks.dart';

class NewTask extends StatefulWidget {
  // Tasks task;

  // NewTask({this.task});
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> with SingleTickerProviderStateMixin {
  double _imageHeight = 256.0;
  double move = 10.0;

  String taskTitle = '', taskTime = '', taskDes = '', taskColor = '';

  bool isRedSelected = false;
  bool isGreenSelected = false;
  bool isCyanSelected = false;
  bool isOrangeSelected = false;
  bool isYellowSelected = false;

  AnimationController _controller;
  Animation<double> animation;
  Animation<Color> colorAnim;

  // FirebaseService firebase; // ! don't use for todo list

  // Key titleKey = new UniqueKey();
  // Key timeKey = new UniqueKey();
  // Key desKey = new UniqueKey();

  @override
  void initState() {
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 900));
    animation = new Tween(begin: 10.0, end: 280.0).animate(_controller);
    colorAnim = new Tween(begin: Colors.red[200], end: Colors.green[200])
        .animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.forward();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
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
          _buildAddCard()
        ],
      ),
    );
  }

  Widget _buildAddCard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.00,
            ),
            Container(
              width: double.infinity,
              height: 500.0,
              child: Column(
                children: <Widget>[
                  new Text(
                    'Add New Task',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Title',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            taskTitle = value;
                          },
                          // controller: _taskTitleController,
                          decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            taskTime = value;
                          },
                          // controller: _taskTimeController,
                          decoration: InputDecoration(
                              hintText: 'Time',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            taskDes = value;
                          },
                          // controller: _taskDesController,
                          decoration: InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0),
                      child: Text(
                        'Color',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      _buildColorOptions(Colors.red, isRedSelected, taskColor),
                      _buildColorOptions(
                          Colors.cyan, isCyanSelected, taskColor),
                      _buildColorOptions(
                          Colors.yellow, isYellowSelected, taskColor),
                      _buildColorOptions(
                          Colors.deepOrange, isOrangeSelected, taskColor),
                      _buildColorOptions(
                          Colors.green, isGreenSelected, taskColor)
                    ],
                  ),
                  _buildSubmitButton()
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  // border: Border.all(width: 2.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -15.0),
                        blurRadius: 15.0)
                  ]),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildFormItem(Key key ,String title, String input) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
  //     child: Column(
  //       children: <Widget>[
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             title,
  //             style: TextStyle(
  //                 fontSize: 20.0,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black),
  //           ),
  //         ),
  //         TextField(
  //           key: key,
  //           onChanged: (value) {
  //             input = value;
  //           },
  //           decoration: InputDecoration(
  //               hintText: title,
  //               hintStyle: TextStyle(
  //                   color: Colors.grey,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 12.0)),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildColorOptions(Color color, bool isSelected, String colorName) {
    isSelected = false;
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            colorName = color.toString();
          });
        },
        child: isSelected
            ? Container(
                width: 30.0,
                height: 30.0,
                child: Stack(
                  children: <Widget>[Icon(Icons.check, color: Colors.white)],
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.withOpacity(0.9)),
              )
            : Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.blue[900]),
                  color: color,
                ),
              ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
      child: Container(
        width: double.infinity,
        height: 60.0,
        child: Stack(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.forward();
                    move = _controller.value.abs();
                  });
                  Navigator.pushNamed(context, 'todo');
                  _uploadDataToFirebase();
                },
                child: Transform(
                  transform: Matrix4.translationValues(move, 0.0, 0.0),
                  child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 45.0),
                ))
          ],
        ),
        decoration: BoxDecoration(
            color: colorAnim.value, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
  // function working properly
  _uploadDataToFirebase() {
    // db = Firestore.instance;
    DocumentReference databaseRef =
        Firestore.instance.collection("todo").document(taskTitle);

    Map<String, dynamic> tasks = {
      "title": taskTitle,
      "time": taskTime,
      "description": taskDes,
      "color": taskColor
    };
    databaseRef.setData(tasks).whenComplete(() {
      print('Task created!');
    });
  }
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
