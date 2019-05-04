import 'package:flutter/material.dart';
import 'package:fun_app/todo_list/todo_list.dart';
import 'record_card.dart';

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
    return Expanded(
      child: ListView(
        children: <Widget>[
          RecCard(rec: records[0]),
          RecCard(rec: records[1]),
          RecCard(rec: records[2]),
          RecCard(rec: records[3]),
          RecCard(rec: records[4]),
        ],
      ),
    );
  }
}
