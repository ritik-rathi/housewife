import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;

  PageIndicator({this.currentIndex, this.pageCount});

  _indicator(bool isActive) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          height: 4,
          decoration: BoxDecoration(
              color: isActive ? Colors.white : Color(0xff4E5167),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0.0, 2.0),
                    color: Colors.black12,
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
