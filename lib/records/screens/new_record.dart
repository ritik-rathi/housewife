import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_app/todo_list/firebase_service.dart';

class NewRecord extends StatefulWidget {
  @override
  _NewRecordState createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> with SingleTickerProviderStateMixin {
  double _imageHeight = 256.0;
  double move = 10.0;

  String role = '', name = '', phone = '';

  bool isRedSelected = false;
  bool isGreenSelected = false;
  bool isCyanSelected = false;
  bool isOrangeSelected = false;
  bool isYellowSelected = false;

  AnimationController _controller;
  Animation<double> animation;
  Animation<Color> colorAnim;

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
                    'Add New Record',
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
                            'Name',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Name',
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
                            'Role',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            role = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Role',
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
                            'Phone Number',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Phone',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  // _buildFormItem(titleKey,'Title', taskTitle),
                  // _buildFormItem(timeKey,'Time', taskTime),
                  // _buildFormItem(desKey,'Description', taskDes),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //         top: 10.0, left: 20.0, right: 20.0),
                  //     child: Text(
                  //       'Color',
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
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

  // Widget _buildColorOptions(Color color, bool isSelected, String colorName) {
  //   isSelected = false;
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
  //     child: InkWell(
  //       onTap: () {
  //         setState(() {
  //           isSelected = !isSelected;
  //           colorName = color.toString();
  //         });
  //       },
  //       child: isSelected
  //           ? Container(
  //               width: 30.0,
  //               height: 30.0,
  //               child: Stack(
  //                 children: <Widget>[Icon(Icons.check, color: Colors.white)],
  //               ),
  //               decoration: BoxDecoration(
  //                   shape: BoxShape.circle, color: color.withOpacity(0.9)),
  //             )
  //           : Container(
  //               width: 30.0,
  //               height: 30.0,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 border: Border.all(width: 1.5, color: Colors.blue[900]),
  //                 color: color,
  //               ),
  //             ),
  //     ),
  //   );
  // }

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
                  // _controller.forward();
                  setState(() {
                    _controller.forward();
                    move = _controller.value.abs();
                  });
                   Navigator.pushNamed(context, 'records');
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

  _uploadDataToFirebase(){
    // db = Firestore.instance;
    DocumentReference databaseRef =
        Firestore.instance.collection("/user/phone/records").document(role);

    Map<String, dynamic> tasks = {
      "role": role,
      "name": name,
      "phone": phone
    };
    // databaseRef.add(tasks).whenComplete((){
    //   print('Task added');
    // });
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
