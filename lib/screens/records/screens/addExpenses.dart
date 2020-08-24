import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int red = 230, green = 12, blue = 12;
bool isRedSelected = false;
bool isBlueSelected = false;
bool isGreenSelected = false;
bool isYellowSelected = false;
bool isPurpleSelected = false;
String title = '', date = '', color = '' , amount = '';

class AddExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _imageHeight = 256.0;

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
                      'Expense Details',
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
                            autofocus: false,
                            onChanged: (value) {
                              title = value;
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
                              'Date',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          TextField(
                            autofocus: false,
                            onChanged: (value) {
                              date = value;
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
                              'Amount',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            onChanged: (value) {
                                amount = value;
                            },
                            // controller: _taskTimeController,
                            decoration: InputDecoration(
                                hintText: 'Amount',
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
                        ColorOptions(
                          red: 240,
                          blue: 12,
                          green: 12,
                          isSelected: isRedSelected,
                        ),
                        ColorOptions(
                          red: 12,
                          green: 240,
                          blue: 141,
                          isSelected: isGreenSelected,
                        ),
                        ColorOptions(
                          red: 46,
                          green: 140,
                          blue: 246,
                          isSelected: isBlueSelected,
                        ),
                        ColorOptions(
                          red: 246,
                          green: 239,
                          blue: 46,
                          isSelected: isYellowSelected,
                        ),
                        ColorOptions(
                          red: 149,
                          green: 13,
                          blue: 183,
                          isSelected: isPurpleSelected,
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: RaisedButton(
                          color: Color(0xFF50CDFF),
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.0)),
                          onPressed: (){
                            _uploadDataToFirebase();
                            Navigator.pop(context);
                          },
                    )
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
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

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ClipPath(
              clipper: ImageClipper(),
              child: Image.asset(
                'assets/images/records.jpg',
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

  // function working properly
  _uploadDataToFirebase() {
    DocumentReference databaseRef =
        Firestore.instance.collection("/user/phone/budget").document(title);

    Map<String, dynamic> tasks = {
      "title": title,
      "time": date,
      "amount": amount,
      "color": {"r": red, "g": green, "b": blue, "o": 0.0},
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

class ColorOptions extends StatefulWidget {
  bool isSelected;
  final int red, green, blue;

  ColorOptions({Key key, this.blue, this.green, this.isSelected, this.red})
      : super(key: key);

  @override
  _ColorOptionsState createState() => _ColorOptionsState();
}

class _ColorOptionsState extends State<ColorOptions> {
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(widget.red, widget.green, widget.blue, 1.0);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.isSelected = !widget.isSelected;
            red = widget.red;
            blue = widget.blue;
            green = widget.green;
            getColorValue();
          });
        },
        child: widget.isSelected
            ? Container(
                width: 30.0,
                height: 30.0,
                child: Stack(
                  children: <Widget>[Icon(Icons.check, color: Colors.white)],
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.withOpacity(0.8)),
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

  void getColorValue() {
    if (widget.isSelected) {
      setState(() {
        red = widget.red;
        blue = widget.blue;
        green = widget.green;
      });
    }
  }
}
