import 'package:flutter/material.dart';
import 'pageviewmodel.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  PageController _controller; // *when we swipe this would control
  int currentPage = 0; // * to maintain a count of the current page  

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
          colors: [Colors.blue[400] , Colors.blue[800] , Colors.blue[900]],
          tileMode: TileMode.clamp,
          stops: [0.0 , 1.0 , 2.0]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              controller: _controller,
              itemCount: pageList.length,
              onPageChanged: (index){
                setState(() {
                 currentPage = index; 
                });
              },
              itemBuilder: (BuildContext context, int index){
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context , child){
                        
                      },
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
