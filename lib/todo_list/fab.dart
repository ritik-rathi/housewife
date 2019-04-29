import 'package:flutter/material.dart';

class Fab extends StatefulWidget {
  final VoidCallback onClick;

  Fab({Key key, this.onClick}) : super(key: key);

  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scaleFactor =
        2 * (_controller.value - 0.5).abs(); // *using this to get the change
    return SizedBox(
      width: 180.0,
      height: 180.0,
      child: new AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildExpandedBackground(),
                FloatingActionButton(
                  onPressed: _control,
                  backgroundColor: _colorAnimation.value,
                  child: Transform(
                      alignment: Alignment.center,
                      transform: new Matrix4.identity()..scale(1.0, scaleFactor),
                      child: _controller.value > 0.5
                          ? Icon(Icons.close)
                          : Icon(Icons.filter_list)),
                ),
              ],
            );
          }),
    );
  }

  open() {
    if (_controller.isDismissed) {
      _controller.forward();
    }
  }

  close() {
    if (_controller.isCompleted) {
      _controller.reverse();
    }
  }

  _control() {
    if (_controller.isDismissed) {
      open();
    } else {
      close();
    }
  }

  Widget _buildExpandedBackground(){
  double size = 20.0 + (180.0 - 20.0) * _controller.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
}
}


