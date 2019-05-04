import 'package:flutter/material.dart';
import 'package:fun_app/todo_list/todo_list.dart';
import 'record_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            right: 10.0,
            top: 220.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/newRecord');
              },
              backgroundColor: Colors.pink,
              child: Icon(Icons.add_box),
            ),
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
          stream: Firestore.instance.collection("user/phone/records").snapshots(),
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
                            child: Container(
                              height: 12.0,
                              width: 12.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.cyan),
                            ),
                          ),
                          new Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '${ds["role"]}',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                                new Text(
                                  '${ds["name"]}',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                ),
                                new Text(
                                  '${ds["phone"]}',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
