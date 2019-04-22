import 'package:flutter/material.dart';
import 'package:fun_app/splash_screens/pageviewmodel.dart';

class PageIndicator extends StatelessWidget {
  int currentIndex;
  int pageCount;

  PageIndicator({this.currentIndex, this.pageCount});

  _indicator(bool isActive) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          height: 4,
          decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.black,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0.0, 2.0),
                    color: Colors.black,
                    blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (var i = 0; i < pageCount; i++) {
      indicatorList
          .add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: _buildPageIndicators());
  }
}
