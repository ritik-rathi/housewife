import 'package:flutter/material.dart';
import 'package:fun_app/appUtils.dart';
import 'package:fun_app/splash_screens/page_indicator.dart';
import 'package:fun_app/splash_screens/splash_screens.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  PageController _controller;
  int currentPage = 0;

  @override
  void initState() {
    _controller = new PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            controller: _controller,
            children: <Widget>[
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
          Positioned(
              bottom: 10.0,
              left: 10.0,
              right: 200.0,
              child: Container(
                width: 100,
                child: PageIndicator(
                  currentIndex: currentPage,
                  pageCount: 3,
                ),
              ))
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xff9388FF));
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff6B77E0),
      child: Column(
        children: <Widget>[
          
        ],
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF50CDFF),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 10.0,
            right: 20.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF2A33C3),
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SplashScreens())),
            ),
          )
        ],
      ),
    );
  }
}
