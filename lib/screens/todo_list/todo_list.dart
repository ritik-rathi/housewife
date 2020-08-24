import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fun_app/screens/todo_list/fab.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  double _imageHeight = 256.0;
  int dateDay = new DateTime.now().day;
  int dateMonth = new DateTime.now().month;
  int dateYear = new DateTime.now().year;

  FlutterLocalNotificationsPlugin notificationsPlugin;

  @override
  void initState() {
    notificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initSettingsAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var initSettingsIOS = new IOSInitializationSettings();
    var initSetting =
        new InitializationSettings(initSettingsAndroid, initSettingsIOS);
    notificationsPlugin.initialize(initSetting,
        onSelectNotification: onSelectNotification);

    Timer(Duration(seconds: 5), () => showNotificationWithSound);
    super.initState();
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
            '$dateDay / $dateMonth / $dateYear',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text("Time to complete tasks"),
            content: new Text('Your task $payload is not complete yet!')));
  }

  Future showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notificationsPlugin.show(
      0,
      'Complete Task',
      'Time to terminate the tasks!',
      platformChannelSpecifics,
      payload: 'Task',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: 'Transition',
            child: ClipPath(
              clipper: ImageClipper(),
              child: Image.asset(
                'assets/images/todo.png',
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: _imageHeight,
                colorBlendMode: BlendMode.srcOver,
                color: new Color.fromARGB(120, 20, 10, 40),
              ),
            ),
          ),
          _buildHeaderIcons(context),
          _buildProfileRow(),
          _buildTimeLine(),
          _buildBottomPart(),
          Positioned(
              right: -40,
              top: 150.0,
              child: Fab(
                hero: 'Todo',
                path1: '/newTask',
                path2: '/completed',
                path3: '/newTask',
              ))
        ],
      ),
    );
  }

  Widget _buildList() {
    // final GlobalKey<AnimatedListState> _listKey =
    //     new GlobalKey<AnimatedListState>();
    // bool leftToRight = true;
    return Expanded(
      child: StreamBuilder(
          stream: Firestore.instance.collection("user/phone/todo").snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              // ?can use flares here to indicate loading
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  backgroundColor: Colors.black,
                ),
              );
            } else if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data.documents[index];
                    int red = ds["color"]["r"];
                    int green = ds["color"]["g"];
                    int blue = ds["color"]["b"];
                    var ref = Firestore.instance
                        .collection('user/phone/todo')
                        .document(ds["title"]);
                    if (!ds["completed"]) {
                      return Dismissible(
                        key: new UniqueKey(),
                        background: new Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          color: Color.fromRGBO(red, green, blue, 1.0),
                        ),
                        onDismissed: (direction) {
                          // ds.data.clear();
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              ref.delete();
                            });
                          }
                          if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              ref.updateData({"completed": true});
                            });
                          }
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: Text('Item removed'),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32.0 - 6.0),
                                child: Container(
                                  height: 12.0,
                                  width: 12.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(
                                          red, green, blue, 1.0)),
                                ),
                              ),
                              new Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      '${ds["title"]}',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                    new Text(
                                      '${ds["description"]}',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Text('${ds["time"]}',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.grey)),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  });
            }
          }),
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
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/splash');
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 32.0)),
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
