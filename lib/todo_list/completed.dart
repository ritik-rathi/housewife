import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isSelected = false;

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  double _imageHeight = 256.0; // image height can vary from screen to screen

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
          _buildTimeLine(),
          _buildBottomPart(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: StreamBuilder(
          stream: Firestore.instance.collection("todo").snapshots(),
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
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 32.0 - 6.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // isSelected = !isSelected;
                                });
                                ds.data.update("completed", (selected) {
                                  selected = true;
                                  print(ds["completed"]);
                                },
                                ifAbsent: (){

                                });
                              },
                              child: isSelected
                                  ? Container(
                                      height: 22.0,
                                      width: 22.0,
                                      child: Icon(Icons.check,
                                          color: Colors.green,),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                          border: Border.all()),
                                    )
                                  : Container(
                                      height: 22.0,
                                      width: 22.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                          border: Border.all()),
                                    ),
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
                    );
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

  Widget _buildListHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Completed?',
            style: new TextStyle(fontSize: 34.0),
          ),
          Text(
            'Automatically deletes completed tasks',
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          )
        ],
      ),
    );
  }
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
              Navigator.pushNamed(context, '.');
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
