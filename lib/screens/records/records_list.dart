import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_app/screens/todo_list/fab.dart';

class Records extends StatefulWidget {
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
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
          _buildBottomPart(),
          Positioned(
              right: -40.0,
              top: 150.0,
              child: Fab(
                hero: 'Records',
                path1: '/addRecord',
                path2: '/newTask',
                path3: '/newTask',
              ))
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
            'Records',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            'All that you need to maintain!', // ? enter the date from Firebase
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    // final GlobalKey<AnimatedListState> _listKey =
    //     new GlobalKey<AnimatedListState>();
    return Expanded(
      child: StreamBuilder(
          stream:
              Firestore.instance.collection("user/phone/records").snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                  backgroundColor: Colors.black,
                  // valueColor: _animation,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data.documents[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      child: Align(
                        alignment: index % 2 == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          width: 300.0,
                          height: 250.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: Color.fromRGBO(212, 230, 252, 1.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(212, 230, 252, 1.0),
                                    offset: Offset(5.0, 25.0),
                                    blurRadius: 80),
                              ]),
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Name : ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 2.0,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: ds["name"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.w700)),
                                          TextSpan(
                                              text: '\n\nPhone :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: ds["phone"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.w700))
                                        ]),
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 15.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      shape: BoxShape.rectangle,
                                      border: Border.all()),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    //edit screen
                                  },
                                  backgroundColor: index % 2 == 0
                                      ? Colors.red[400]
                                      : Colors.blue[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
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
