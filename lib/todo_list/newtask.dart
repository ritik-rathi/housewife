import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  double _imageHeight = 256.0;
  bool isRedSelected = false;
  bool isGreenSelected = false;
  bool isCyanSelected = false;
  bool isOrangeSelected = false;
  bool isYellowSelected = false;

  @override
  Widget build(BuildContext context) {
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
                  _buildFormItem('Title'),
                  _buildFormItem('Time'),
                  _buildFormItem('Description'),
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
                      _buildColorOptions(Colors.red , isRedSelected),
                      _buildColorOptions(Colors.cyan , isCyanSelected),
                      _buildColorOptions(Colors.yellow , isYellowSelected),
                      _buildColorOptions(Colors.deepOrange , isOrangeSelected),
                      _buildColorOptions(Colors.greenAccent , isGreenSelected)
                    ],
                  )
                  // Container(
                  //   height: 50.0,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 1.0 , color: Colors.deepPurple),
                  //     borderRadius: BorderRadius.circular(25.0)
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(20.0),
                  //     child: TextField(
                  //       decoration: InputDecoration.collapsed(
                  //         hintText: 'Title'
                  //       ),
                  //     ),
                  //   ),
                  // )
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

  Widget _buildFormItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          TextField(
            onSubmitted: (value) {},
            decoration: InputDecoration(
                hintText: title,
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0)),
          )
        ],
      ),
    );
  }

  Widget _buildColorOptions(Color color, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
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
