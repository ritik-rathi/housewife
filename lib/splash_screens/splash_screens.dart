import 'package:flutter/material.dart';
import 'package:fun_app/splash_screens/page_indicator.dart';
import 'pageviewmodel.dart';
import 'package:gradient_text/gradient_text.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  PageController _controller; // *when we swipe this would control
  int currentPage = 0; // * to maintain a count of the current page
  // bool showDetails = false;

  // * initialize the pagecontroller
  @override
  void initState() {
    _controller = new PageController(initialPage: currentPage);
    super.initState();
  }

  // ! to avoid memory leaks
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[400], Colors.blue[800], Colors.blue[900]],
              tileMode: TileMode.clamp,
              stops: [0.0, 1.0, 2.0])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
           _initScreen(context),
            Positioned(
              left: MediaQuery.of(context).size.width / 4 + 20,
              bottom: 55.0,
              child: Container(
                  width: 160.0,
                  child: PageIndicator(
                    currentIndex: currentPage,
                    pageCount: pageList.length,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _initScreen(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: pageList.length,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
          // print(currentPage);
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // var page = pageList[index];
                var delta;
                var y = 1.0;

                if (_controller.position.haveDimensions) {
                  delta = _controller.page - index;
                  y = 1.0 - delta.abs().clamp(0.0, 1.0);
                }
                return Transform(
                  transform:
                      Matrix4.translationValues(0.0, 200.0 * (1 - y), 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap:(){
                          Navigator.pushNamed(context, pageList[index].screenPath);
                        },
                        child: Image.asset(pageList[index].imgPath , fit: BoxFit.cover,)),
                      Stack(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.2,
                            child: GradientText(pageList[index].title,
                                style: TextStyle(
                                    fontSize: 80.0,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w900),
                                gradient: LinearGradient(
                                    colors: pageList[index].gradients)),
                          ),
                          GradientText(pageList[index].title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 70.0,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w900),
                              gradient: LinearGradient(
                                  colors: pageList[index].gradients)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Text(
                          pageList[index].description,
                          style: TextStyle(
                              fontSize: 20.0, color: Color(0xFF9B9B9B)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
